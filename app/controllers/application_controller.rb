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

  def sendgrid
    SendGrid::Client.new do |c|
      c.api_key = ENV['SENDGRID_ACCESS_KEY']
    end
  end

  def api_response(items)
    respond_to do |format|
      format.html
      format.js
      format.json do
        render json: items
      end
    end
  end

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

  def image?(file_path)
    FastImage.size(file_path, raise_on_failure: true)
    return true
  rescue
    return false
  end
end
