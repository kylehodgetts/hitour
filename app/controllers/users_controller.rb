class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    items = User.where.not(id: session[:user_id])
    @users = []
    items.each do |item|
      @users << {
        id: item.id,
        data: item.email + ' Activated:' + item.activated.to_s,
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
  end

  def create
    randomSequence= [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    params[:user][:password] = ""+(0...25).map { randomSequence[rand(randomSequence.length)] }.join
    @user = User.new(user_params)
    @user.activated = false
    # TODO This will require to be changed to make it more convenient and esthetic.
    welcomeHtml = "<h2> You have received an invitation to join the HiTour CMS. </h2></br>"
    emailHtml = "<h3>Use your Email address : </br><b>#{@user.email}</b> </h5>"
    passwordHtml = "<h3> and the following password:</h3></br><b>#{@user.password}</b>"
                                                       # TODO change the url
    directionHtml = "<h3>To login to :<a href="'https://localhost:3000/login'">HiTour.</a></h3></br><h6>You will be able to reset your password once logged in.</h6>"
    email = SendGrid::Mail.new do |m|
     m.to      = "#{@user.email}"
     m.from    = 'services@Hitour.com'
     m.subject = 'HiTour! content management system invitation.'
     m.html =  welcomeHtml+emailHtml+passwordHtml+directionHtml
     end
    $sendgrid.send(email)
    render json: ['Added user!'], status: 200 if @user.save
  end

  def update
    @user = User.find(params['id'])
    password_params = params['user']
    if password_params['password'].eql? password_params['cpassword']
      params[:user][:password] = password_params['cpassword']
      @user.update_attributes(user_params)
      render json: ['Successfully updated password'], status: 200
    else
      render json: ['Passwords must be non empty and match'], status: 200
    end
  end

  def destroy
    #TODO only give the ability to remove a user it has been added by himself or if the user is still unactivated
    user = User.find(params[:id])
    user.delete
    render json: ['Successfully deleted user'], status: 200
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :activated)
  end
end
