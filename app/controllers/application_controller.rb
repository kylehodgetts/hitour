class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  helper_method :authenticate_user!, :current_user

  # Return current user or nil, if a user is not logged in
  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  # If current_user returns nil, redirect to the log in page
  def authenticate_user!
    redirect_to login_path unless current_user
  end
end
