# Version 1.0
# Tour Sessions Controller responsible for creating and maintaining
# Tour Session relationships
class TourSessionsController < ApplicationController
  before_action :authenticate_user!

  # Save a Data Audience pair to the database
  # Raise a RecordNotUnique exception if a relationship already exists
  # between a given data and audience
  def create
    # Generate random passphrase if not given
    generate_passphrase
    begin
      tour_session = TourSession.new(tour_session_params)
      tour_session.save
      if tour_session.errors.full_messages.empty?
        render json: ['Succesfully created tour session']
      else
        render json: [tour_session.errors.full_messages.first]
      end
		rescue ActiveRecord::RecordNotUnique
			 render json: ['Please select a different tour or different start date']
		end
  end

  # Update a given TourSession whose id matches that
  # given in the params
  # Return a success message, if record is updated
  # Otherwise, return an error message
  def update
    tour_session = TourSession.find(params[:id])
    tour_session.passphrase = params[:tour_session][:passphrase]
    if tour_session.save
      render json: ['Successfully updated tour session'], status: 200
    else
      render json: ['Error: ' + tour_session.errors.full_messages.first]
    end
  end

  # Destroy a Tour Session pair whose relationship record
  # matches the given id.
  def destroy
    tour_session = TourSession.find(params[:id])
    tour_session.destroy
    render json: ['Succesfully deleted tour session']
  end

  # Send email to the given email in the params
  # This will give the owner of the email address
  # access to the CMS
  def send_email
    email = params[:email]
    tour_session = TourSession.find(params[:id])
    response = send_invitation_email(email, tour_session)
    return render json: ['Succesfully sent email'] if response.code == 200
    render json: ['Couldnt send email']
  end

  private

  # Require a record of type TourSession and permit the given attributes
  def tour_session_params
    params.require(:tour_session)
          .permit(:tour_id, :name, :start_date, :duration, :passphrase)
  end

  # Generate a passphrase to allow mobile clients
  # to access the associated tour
  def generate_passphrase
    if params[:tour_session][:passphrase].nil?
      random_word = RandomWord.nouns.next + SecureRandom.hex(3)
      params[:tour_session][:passphrase] = random_word
    end
  end

  # Prepare invitation email to send to the given email
  def send_invitation_email(email, tour_session)
    @tour_session = tour_session
    email = SendGrid::Mail.new do |m|
     m.to      = email
     m.from    = 'invitation@Hitour.com'
     m.subject = 'HiTour - Invitation'
     m.html = render_to_string(action: 'email_template', layout: false)
    end
    sendgrid.send(email)
  end
end
