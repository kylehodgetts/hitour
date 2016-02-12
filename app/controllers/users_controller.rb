class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    @user.save
  end

  def update
    # Update a user
    # Find the current user
    # Take the new vaulues and save them for the current user
    # Update the user db with the updated user
  end

  def destroy
    # Delete a user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
