class TourSessionsController < ApplicationController
  before_action :authenticate_user!
  include RQRCode
  def create
    # Generate random passphrase
    params[:tour_session][:passphrase] = RandomWord.nouns.next
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

  def update
    tour_session = TourSession.find(params[:id])
    if tour_session.update_attributes(tour_session_params)
      render json: ['Successfully updated tour session'], status: 200
    else
      render json: ['Could not update tour session']
    end
  end

  def destroy
    tour_session = TourSession.find(params[:id])
    tour_session.destroy
    render json: ['Succesfully deleted tour session']
  end

  def send_email
    tour_session = TourSession.find(params[:id])
    response = session_invitation(params[:email], tour_session)
    return render json: ['Succesfully sent email'] if response.code == 200
    render json: ['Something went wrong']
  end

  def session_invitation(to, tour_session)
    email = SendGrid::Mail.new do |m|
     m.to      = to
     m.from    = 'invitation@Hitour.com'
     m.subject = 'HiTour - Invitation'
     m.html =  generate_message(tour_session)
    end
    $sendgrid.send(email)
  end

  def generate_message(tour_session)
    title = '<p>Dear Receipient, </p>'
    regards = '<br><br><br><p>Kind Regards, <br>The HiTour Team</p><br>'
    android_link = '<a>Download Android App</a><br>'
    ios_link = '<a>Download IOS App</a><br>'
    title + session_message(tour_session) + regards + android_link + ios_link
  end

  def session_message(tour_session)
    date = tour_session.start_date.to_formatted_s(:long_ordinal)
    message = "<p>You have been invited to take part in the
    <b>#{tour_session.tour.name}</b>.<br>"
    message += "<br>Please scan the QR code below
    (QR may not render on all email clients) or enter the passphrase
    <b>#{tour_session.passphrase}</b> into the mobile app."
    session_info = "<p>The contents of the tour will be available for
    <b>#{tour_session.duration} days </b>starting on <b>#{date}</b>.</p>"
    svg = RQRCode::QRCode.new('SESSION-' + tour_session.passphrase).as_svg
    message + session_info + svg
  end

  private

  def tour_session_params
    params.require(:tour_session)
          .permit(:tour_id, :name, :start_date, :duration, :passphrase)
  end
end
