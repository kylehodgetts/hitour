class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    redirect_to root_path unless @current_user.id == params[:id].to_i
    @user = current_user
  end

  def create
    params[:password] = "password"
    @user = User.new(user_params)
    email = SendGrid::Mail.new do |m|
     m.to      = :email
     m.from    = 'services@Hitour.com'
     m.subject = 'Sending with SendGrid is Fun'
     m.html = 'your password is : '+:password
     end
  $sendgrid.send(email)
    @user.save
    redirect_to @user
  end

  def update
    flash[:user_save] = 'false'
    flash[:save_message] = 'Passwords must match and be non-empty!'
    @user = User.find_by(params[:email])
    unless params[:password] != params[:cpassword]
      @user.password = params[:password]
      flash[:user_save] = 'true' if @user.save
      flash[:save_message] = 'Profile updated successfully!'
    end
    redirect_to @user
  end

  def destroy
    # Delete a user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
