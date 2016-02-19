class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    items = User.where.not(id: session[:user_id])
    @users = []
    items.each do |item|
      @users << {
        id: item.id,
        data: item.email,
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
    @user = current_user
  end

  def create
    # Temporary until mailer is set up
    @user = User.new(email: params[:user][:name], password: 'password')
    @user.save
    render json: ['Successfully added user'], status: 200
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
    redirect_to user_path
  end

  def destroy
    user = User.find(params[:id])
    user.delete
    render json: ['Successfully deleted user'], status: 200
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
