# Version 1.0
# ApplicationController for methods that will be used as
# part of child class Controllers
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  helper_method :authenticate_user!, :current_user,
                :api_authenticate!, :api_response
  # Return current user or nil, if a user is not logged in
  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  # If current_user returns nil, redirect to the log in page
  def authenticate_user!
    redirect_to login_path unless current_user
  end

  def api_authenticate!
    render json: 'API access key is invalid' unless
                                    params[:access_key].eql?(ENV['ACCESS_KEY'])
  end

  def redirect_error_page(error)
    redirect_to "#{root_url}#{error}.html", status: error
  end

  # Instantiate a new SendGrid client
  def sendgrid
    SendGrid::Client.new do |c|
      c.api_key = ENV['SENDGRID_ACCESS_KEY']
    end
  end

  # Return appriate reponses for the
  # requested types
  def api_response(items)
    respond_to do |format|
      format.html
      format.js
      format.json do
        render json: items
      end
    end
  end

  # Upload a file to AWS with the given file extension
  # and from the given file path
  def upload_to_s3(file_extension, file_path)
    s3 = Aws::S3::Resource.new
    obj = s3.bucket('hitourbucket').object(SecureRandom.hex + file_extension)
    obj.upload_file(file_path, acl: 'public-read')
    obj.public_url
  end

  def analyse_upload(file_path, file_extension)
    # Just Upload to S3 If file is an image
    return upload_to_s3 file_extension, file_path if image?(file_path)
    # Analyse video, compress if neccesary
    analayse_video(file_path)
  end

  # Analyse the video to determine the extension
  # If mp4, compress the video
  # else assign mp4 as the file path and then recursively
  # call method
  # **AVI videos are too large for storage on S3**
  def analayse_video(file_path)
    movie = FFMPEG::Movie.new(file_path)
    # Max Size of 60MB in bytes
    max_size = 62_914_560
    if !(file_path.include?'mp4') || (movie.size > max_size)
      # Compress video since not mp4 or too big
      return compress_video(file_path)
    else
      # Upload to S3 as video is fine
      return upload_to_s3 '.mp4', file_path
    end
  end

  # Compresses video into mp4
  def compress_video(file_path)
    movie = FFMPEG::Movie.new(file_path)
    options = {
      resolution: '640x480'
    }
    movie.transcode('compressed.mp4', options)
    url = upload_to_s3 '.mp4', 'compressed.mp4'
    FileUtils.rm('compressed.mp4')
    url
  end

  # Return true if given file is an image File
  # Return false otherwise
  def image?(file_path)
    FastImage.size(file_path, raise_on_failure: true)
    return true
  rescue
    return false
  end

  # Retrieves quiz data for a particular tour
  def quiz_data(tour_id)
    # Find available quizzes - Dominique
    tour_quiz = TourQuiz.where(tour_id: tour_id)
    return unless tour_quiz.exists?
    @quiz = Quiz.find(tour_quiz.first.quiz_id)
    {
      quiz: @quiz,
      questions: quiz_questions
    }
  end

  # Retrieves all questions for a quiz
  def quiz_questions
    @quiz.questions.map do |question|
      question.as_json.merge(
        delete_url: delete_question_path(question[:id]),
        submit_url: submit_question_path,
        answers: answers(question[:id])
      )
    end
  end

  # Retrieves all answers for a question
  def answers(question_id)
    answers = Answer.where(question_id: question_id)
    answers.map do |answer|
      answer.as_json.merge(
        delete_url: delete_answer_path(answer[:id])
      )
    end
  end
end
