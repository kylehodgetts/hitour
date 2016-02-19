class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  #    email = SendGrid::Mail.new do |m|
  #    m.to      = 
  #    m.from    = 'services@Hitour.com'
  #    m.subject = 'Sending with SendGrid is Fun'
  #    m.html = 'your password is : '
  #    end
  # $sendgrid.send(email)
  end

  def new
    @user = User.new
  end

  def show
    redirect_to root_path unless @current_user.id == params[:id].to_i
    @user = current_user
  end

  def create
    randomSequence= [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    params[:user][:password] = ""+(0...25).map { randomSequence[rand(randomSequence.length)] }.join
    @user = User.new(user_params)
    @user.activated = false
    welcomeHtml = "<h2> You have received an invitation to join the HiTour CMS. </h2></br>"
    emailHtml = "<h3>Use your Email address : </br><b>#{@user.email}</b> </h5>"
    passwordHtml = "<h3> and the following password:</h3></br><b>#{@user.password}</b>"
    directionHtml = "<h3>To login to :<a href="'https://localhost:3000/login'">HiTour.</a></h3></br><h6>You will be able to reset your password once logged in.</h6>"
    email = SendGrid::Mail.new do |m|
     m.to      = "#{@user.email}"
     m.from    = 'services@Hitour.com'
     m.subject = 'HiTour! content management system invitation.'
     m.html =  welcomeHtml+emailHtml+passwordHtml+directionHtml
     end
    $sendgrid.send(email)
    @user.save
    redirect_to usersi_path
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
    params.require(:user).permit(:email, :password, :activated)
  end
end
