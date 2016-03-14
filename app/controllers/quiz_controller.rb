class QuizController < ApplicationController
  def index
    @quiz = Quiz.includes(:questions).map do |quiz|
      quiz.as_json.merge(
        data: quiz.name,
        delete_url: delete_quiz_path(quiz),
        show_url: quiz_path(quiz)
      )
    end
    api_response(@quiz)
  end

  def attempt_quiz
    tour_session = TourSession.where(passphrase: params[:id])
    return redirect_error_page(403) unless tour_session.exists?
    @quiz_data = quiz_data(tour_session.first.tour.id)
    @quiz_data = @quiz_data.as_json
    @tour = Tour.find(tour_session.first.tour.id)
    api_response(@quiz_data)
  end

  def submit_question
    return render json: ['No answer'] if params[:answer].nil?
    session[:questions] ||= []
    answer = Answer.find(params[:answer][:id])
    question_id = params[:question][:id]
    if answer.is_correct
      increment_question_correct(question_id)
      render json: { correct: true }
    else
      increment_question_wrong(question_id)
      answer = Answer.where(question_id: question_id, is_correct: true).first
      render json: { correct: false, answer: answer.as_json }
    end
    session[:questions] << question_id
  end

  def correct_answer(question_id)
    Answer.where(question_id: question_id, is_correct: true).first
  end

  def increment_question_correct(question_id)
    unless session[:questions].include?question_id
      question = Question.find(question_id)
      current = question.correctly_answered
      question.update_attribute(:correctly_answered, current + 1)
    end
  end

  def increment_question_wrong(question_id)
    unless session[:questions].include?question_id
      question = Question.find(question_id)
      current = question.wrongly_answered
      question.update_attribute(:wrongly_answered, current + 1)
    end
  end

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

  def show
    @quiz = Quiz.includes(:questions).find(params[:id])
    questions = quiz_questions
    @quiz = @quiz.as_json
    @quiz['questions'] = questions
    api_response(@quiz)
  end

  def create
    quiz = Quiz.new(quiz_params)
    quiz.save
    if quiz.errors.full_messages.empty?
      render json: ['Succesfully created quiz']
    else
      render json: [quiz.errors.full_messages.first]
    end
  rescue ActiveRecord::RecordNotUnique
	  render json: ['That name has already been used.']
  end

  def update
    quiz = Quiz.find(params[:id])
    if quiz.update_attributes(quiz_params)
      render json: ['Successfully updated Quiz'], status: 200
    else
      render json: [quiz.errors.full_messages.first]
    end
  end

  def destroy
    Quiz.find(params[:id]).destroy
    render json: ['Deleted quiz']
  end

  private

  def quiz_params
    params.require(:quiz).permit(:name)
  end

  def quiz_questions
    @quiz.questions.map do |question|
      question.as_json.merge(
        delete_url: delete_question_path(question[:id]),
        submit_url: submit_question_path,
        answers: answers(question[:id])
      )
    end
  end

  def answers(question_id)
    answers = Answer.where(question_id: question_id)
    answers.map do |answer|
      answer.as_json.merge(
        delete_url: delete_answer_path(answer[:id])
      )
    end
  end
end
