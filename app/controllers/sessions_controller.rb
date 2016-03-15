# Version 1.1
# Sessions Controller responsible for handling users logging
# in and out from the CMS
class SessionsController < ApplicationController
  # If user is already logged in
  # redirect them from the log in page to main page
  def new
    redirect_to root_path if session[:user_id]
  end

  # Create a user session
  def create
    # Find the user in the database by the email given
    @user = User.find_by_email(params[:email].downcase)
    redirect_to root_path unless @user
    if @user
      password = params[:password]
      # If the user is not nil and the given password matches
      create_user_session if @user.authenticate(password)
      set_temporary_password if password.eql? @user.temporarypassword
    end
  end

  # Destroy user session
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  # Called when a user has been successfully authenticated
  # Sets the current session's user id to the authenticated user
  def create_user_session
    # Create a user session and redirect to main page
    session[:user_id] = @user.id
    if @user.activated
      redirect_to root_path
    else
      redirect_to update_profile_path(@user.id)
    end
  end

  # Called when the user's password is equal to the temporarypassword
  # Reset the password of the user to the
  # temporary password and remove the previously
  # given temporary password.
  def set_temporary_password
    @user.update_attribute(:password, params[:password])
    @user.update_attribute(:temporarypassword, '')
    @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect_to update_profile_path(@user.id)
  end
end
