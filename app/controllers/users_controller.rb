class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    items = User.where.not(id: session[:user_id])
    @users = []
    items.each do |item|
      @users << {
        id: item.id,
        data: item.email + ' Activated:' + item.activated.to_s,
        delete_url: delete_user_path(item)
      }
    end
    api_response(@users)
  end

  def new
    @user = User.new
  end

  def show
    redirect_to root_path unless @current_user.id == params[:id].to_i
  end

  def create
    randomSequence= [('A'..'Z')].map { |i| i.to_a }.flatten
    params[:user][:password] = ""+(0...25).map { randomSequence[rand(randomSequence.length)] }.join
    @user = User.new(user_params)
    @user.activated = false
    welcomeHtml = "<h3> HiTour - Please Activate Your Account</h3></br></br>"
    emailHtml ="<h3>Email: <b><a href="'#'" style="'text-decoration:none !important; text-decoration:none;'">#{@user.email.upcase}</b> </h3>"
    passwordHtml = "</br><h3>Password: <b>#{@user.password}</b></h3>"
    url= '<a href="'+request.original_url+'">Activate Account</a>'
    directionHtml ="<h3>"+url+" (Please set a password, once activated.)</h3></br>"
    email = SendGrid::Mail.new do |m|
     m.to      = "#{@user.email}"
     m.from    = 'services@Hitour.com'
     m.subject = 'HiTour - Email Activation'
     m.html =  welcomeHtml+emailHtml+passwordHtml+directionHtml
     end
    $sendgrid.send(email)
    render json: ['Added user!'], status: 200 if @user.save
  end

  def update
    @user = User.find(params['id'])
    password_params = params['user']
    if password_params['password'].eql? password_params['cpassword']
      params[:user][:password] = password_params['cpassword']
      @user.update_attributes(user_params)
      render json: ['Successfully updated password'], status: 200
    else
      render json: ['Passwords must be non empty and match'], status: 200
    end
  end

  def destroy
    user = User.find(params[:id])
    user.delete
    render json: ['Successfully deleted user'], status: 200
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :activated)
  end
end
