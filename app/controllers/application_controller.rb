class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to user_omniauth_authorize_url(provider: :google_oauth2)
    end
  end
end
