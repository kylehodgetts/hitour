class PasswordResetController < ApplicationController
  require 'mailing'
  def new
  end

  def create
  	@user = User.find_by_email(params[:email])
  	if @user
  		reset_password = SecureRandom.hex(25)
	    @user.update_attribute(:temporarypassword,reset_password)
      mailingReset = Mailing.new(@user,request.original_url)
      mailingReset.reset_password
    	redirect_to root_path
	  else
	  redirect_to password_reset_path
  	end
  end

end
