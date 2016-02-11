class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  helper_method :authenticate_user, :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    redirect_to login_path unless current_user
  end
end
