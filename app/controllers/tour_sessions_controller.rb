class TourSessionsController < ApplicationController
  before_action :authenticate_user!
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

  private

  def tour_session_params
    params.require(:tour_session)
          .permit(:tour_id, :name, :start_date, :duration, :passphrase)
  end
end
