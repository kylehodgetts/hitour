class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  helper_method :authenticate_user, :current_user

  # Return current user or nil, if a user is not logged in
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # If current_user returns nil, redirect to the log in page
  def authenticate_user!
    redirect_to login_path unless current_user
  end
end
