class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    if @current_user.activated
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
    else
      redirect_to update_profile_path(@current_user.id)
    end
  end

  def show
    redirect_to root_path unless @current_user.id == params[:id].to_i
  end

  def create
    redirect_to update_profile_path(@current_user.id) unless @current_user.activated
    params[:user][:password] = SecureRandom.hex(25)
    @user = User.new(user_params)
    @user.temporarypassword = SecureRandom.hex(25)
    @user.activated = false
    send_activation_email
    render json: ['Activation email sent!'], status: 200 if @user.save
  end

  def send_activation_email
    redirect_to update_profile_path(@current_user.id) unless @current_user.activated
    @url = root_url
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
    redirect_to update_profile_path(@current_user.id) unless @current_user.activated
    user = User.find(params[:id])
    user.delete
    render json: ['Successfully deleted user'], status: 200
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :activated)
  end
end
