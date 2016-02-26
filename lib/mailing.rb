class Mailing

	def initialize(user, baseUrl)
		@user = user
		@url = baseUrl
	end

	#Sends a temporary password to the user
	def reset_password
		welcomeHtml = "<h3> HiTour - Password Reset Request</h3></br></br>"
	    emailHtml ="<h3>Email: <b><a href="'#'" style="'text-decoration:none !important; text-decoration:none;'">#{@user.email.upcase}</b> </h3>"
	    passwordHtml = "</br><h3>Temporary password: <b>#{@user.temporarypassword}</b></h3>"
	    url= '<a href="'+@url+'">Activate Account</a>'
	    directionHtml ="<h3>"+url+" (YOu will be able to set a more convenient password, once logged in.)</h3></br>"
	    email = SendGrid::Mail.new do |m|
	     m.to      = "#{@user.email}"
	     m.from    = 'services@Hitour.com'
	     m.subject = 'HiTour! Content management system password reset.'
	     m.html =  welcomeHtml+emailHtml+passwordHtml+directionHtml
    	 end
    	$sendgrid.send(email)
    end

    #Sends an invitation to a user
    def user_invitation
	    welcomeHtml = "<h3> HiTour - Please Activate Your Account</h3></br></br>"
	    emailHtml ="<h3>Email: <b><a href="'#'" style="'text-decoration:none !important; text-decoration:none;'">#{@user.email.upcase}</b> </h3>"
	    passwordHtml = "</br><h3>Password: <b>#{@user.password}</b></h3>"
	    url= '<a href="'+@url+'">Activate Account</a>'
	    directionHtml ="<h3>"+url+" (Please set a password, once activated.)</h3></br>"
	    email = SendGrid::Mail.new do |m|
	     m.to      = "#{@user.email}"
	     m.from    = 'services@Hitour.com'
	     m.subject = 'HiTour - Email Activation'
	     m.html =  welcomeHtml+emailHtml+passwordHtml+directionHtml
	     end
	    $sendgrid.send(email)
    end
end
