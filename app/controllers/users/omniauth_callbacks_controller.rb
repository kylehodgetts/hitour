module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      # Method implemented in User model class
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user
        sign_in_and_redirect @user, event: :authentication
      else
        session['devise.google_data'] = request.env['omniauth.auth']
        redirect_to '/'
      end
    end

    def failure
      redirect_to root_path
    end
  end
end
