class PasswordResetController < ApplicationController
  def create
  	@user = User.find_by_email(params[:email])
    if @user
      reset_password = SecureRandom.hex(25)
      @user.update_attribute(:temporarypassword, reset_password)
      send_reset_email
    	redirect_to root_path
    else
      redirect_to password_reset_path
    end
  end

  def send_reset_email
    @url = root_url
    email = SendGrid::Mail.new do |m|
     m.to      = @user.email
     m.from    = 'services@Hitour.com'
     m.subject = 'HiTour - Password Reset'
     m.html = render_to_string(action: 'reset_template', layout: false)
    end
    sendgrid.send(email)
  end
end
