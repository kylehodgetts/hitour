class PasswordResetController < ApplicationController

  def new
    
  end

  def create
  	@user = User.find_by_email(params[:email].downcase)
  	if @user
		randomSequence= [('A'..'Z')].map { |i| i.to_a }.flatten
	    reset_password= ""+(0...25).map { randomSequence[rand(randomSequence.length)] }.join
	    @user.update_attribute(:temporarypassword,reset_password)
		welcomeHtml = "<h3> HiTour - Password Reset Request</h3></br></br>"
	    emailHtml ="<h3>Email: <b><a href="'#'" style="'text-decoration:none !important; text-decoration:none;'">#{@user.email.upcase}</b> </h3>"
	    passwordHtml = "</br><h3>Temporary password: <b>#{@user.temporarypassword}</b></h3>"
	    url= '<a href="'+request.original_url+'">Activate Account</a>'
	    directionHtml ="<h3>"+url+" (YOu will be able to set a more convenient password, once logged in.)</h3></br>"
	    email = SendGrid::Mail.new do |m|
	     m.to      = "#{@user.email}"
	     m.from    = 'services@Hitour.com'
	     m.subject = 'HiTour! Content management system password reset.'
	     m.html =  welcomeHtml+emailHtml+passwordHtml+directionHtml
    	 end
    	$sendgrid.send(email)
    	redirect_to root_path
	else
	redirect_to password_reset_path
	end
  end
 
end