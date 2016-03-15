# Version 1.0
# Password Reset Controller responsible for creating temporary passwords
# for those user who have forgotten their passwords
class PasswordResetController < ApplicationController
  # Create a SecureRandom hex password and assign it as the given users
  # temporary password
  def create
    user = User.find_by_email(params[:email])
    if user
      reset_password = SecureRandom.hex(25)
      user.update_attribute(:temporarypassword, reset_password)
      send_reset_email
      redirect_to root_path
    else
      redirect_to password_reset_path
    end
  end

  # Send the recovery email to the user's email account
  # containing the temporary password
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
