# Version 1.0
# Users Controller responsible for creating and manipulating
# user records that denote real users of the CMS
class UsersController < ApplicationController
  before_action :authenticate_user!

  # Prepare all user records for response via the
  # hiTour API
  def index
    if @current_user.activated
      items = User.where.not(id: session[:user_id])
      @users = []
      items.each do |item|
        @users << {
          id: item.id,
          data: item.email,
          delete_url: user_path(item),
          activated: item.activated
        }
      end
      api_response(@users)
    else
      redirect_to user_path(@current_user.id)
    end
  end

  # Show the profile page of the user
  def show
    redirect_to root_path unless @current_user.id == params[:id].to_i
  end

  # Create a User record, saving it to the database
  # Send user an activation email to set up account
  # Return a success message, if email is sent
  def create
    redirect_path = user_path(@current_user.id)
    redirect_to redirect_path unless @current_user.activated
    params[:user][:password] = SecureRandom.hex(25)
    @user = User.new(user_params)
    @user.temporarypassword = SecureRandom.hex(25)
    @user.activated = false
    send_activation_email
    render json: ['Activation email sent!'], status: 200 if @user.save
  end

  # Update a given user whose id matches that
  # given in the params
  # Return a success message, if record is updated
  # Otherwise, return an error message
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

  # Destroy the user whose id matches that
  # given in the params
  def destroy
    redirect_path = user_path(@current_user.id)
    redirect_to redirect_path unless @current_user.activated
    user = User.find(params[:id])
    user.delete
    render json: ['Successfully deleted user'], status: 200
  end

  # Prepare activation email to send to a newly
  # added user
  def send_activation_email
    @url = root_url
    email = SendGrid::Mail.new do |m|
     m.to      = @user.email
     m.from    = 'services@Hitour.com'
     m.subject = 'HiTour - Account Activation'
     m.html = render_to_string(action: 'activation_template', layout: false)
    end
    sendgrid.send(email)
  end

  private

  # Require a record of type User and permit the given attributes
  def user_params
    params.require(:user).permit(:email, :password, :activated)
  end
end
