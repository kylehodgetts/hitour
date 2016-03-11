class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    items = User.where.not(id: session[:user_id])
    @users = []
    items.each do |item|
      @users << {
        id: item.id,
        data: item.email,
        delete_url: delete_user_path(item),
        activated: item.activated
      }
    end
    api_response(@users)
  end

  def show
    redirect_to root_path unless @current_user.id == params[:id].to_i
  end

  def create
    params[:user][:password] = SecureRandom.hex(25)
    @user = User.new(user_params)
    @user.activated = false
    send_activation_email
    render json: ['Activation email sent!'], status: 200 if @user.save
  end

  def send_activation_email
    @url = request.original_url
    email = SendGrid::Mail.new do |m|
     m.to      = @user.email
     m.from    = 'services@Hitour.com'
     m.subject = 'HiTour - Account Activation'
     m.html = render_to_string(action: 'activation_template', layout: false)
    end
    sendgrid.send(email)
  end

  def update
    @user = User.find(params['id'])
    password_params = params['user']
    if password_params['password'].eql? password_params['cpassword']
      params[:user][:password] = password_params['cpassword']
      @user.update_attributes(user_params)
      @user.update_attribute(:activated, true)
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
