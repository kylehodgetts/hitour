class ToursController < ApplicationController
	include RQRCode
	before_action :authenticate_user!

	def index
		items = Tour.includes(:points)
		@tours = []
		items.each do |item|
			@tours << item.as_json.merge(
			  data: item.name,
			  delete_url: delete_tour_path(item),
			  show_url: tour_path(item)
			)
		end
		@audiences = Audience.all.map do |audience|
			[audience.name, audience.id]
		end
		api_response(@tours)
	end

	def show
		delete_expired_sessions
		@tour = Tour.includes(:tour_sessions).find(params[:id])
		@audiences = Audience.all
		@audience = Audience.find(@tour.audience_id)
		@tour_points = tour_points(params[:id])
		@tour_sessions = tour_sessions(@tour)
		@tour_points = [] if @tour_points.nil?
		items = [
		  tour: 				 @tour,
		  audience:			 @audience,
		  points:  			 @tour_points,
			 tour_sessions: @tour_sessions,
			 feedbacks: tour_feedbacks
		]
		api_response(items)
	end

	def tour_sessions(tour)
		tour.tour_sessions.map do |session|
			session.as_json.merge(
				 start_date: session.start_date.to_formatted_s(:long_ordinal),
 				delete_url: delete_tour_session_path(session),
 				update_url: update_tour_session_path(session),
 				email_url: tour_session_invitation_path(session)
			)
		end
	end

	def tour_feedbacks
		@tour.feedbacks.map do |feedback|
			feedback.as_json.merge(
					delete_url: delete_feedback_path(feedback)
			)
		end
	end

	def pdf
		@tour = Tour.find(params[:id])
		@audience = Audience.find(@tour.audience_id)
		@tour_points = tour_points(params[:id])
		render pdf: @tour.name.to_s
	end

	def tour_points(tour_id)
		TourPoint.where(tour_id: tour_id).order(:rank).map do |tp|
			{
			  id: tp.point.id,
				 name: tp.point.name,
				 rank: tp.rank,
				 show_url: point_path(tp.point),
				 delete_url: delete_tour_point_path(tp),
				 increase_url: increase_tour_point_path(tp),
				 decrease_url: decrease_tour_point_path(tp),
				 pdf_url: tour_pdf_path(tp),
				 qr_code: QRCode.new("POINT-#{tp.point.id}", size: 3),
				 description: tp.point.description,
				 url: tp.point.url
			}
		end
	end

	def update
		@tour = Tour.find(params[:id])
		if @tour.update_attributes(tour_params)
			render json: ['Successfully updated tour'], status: 200 if @tour.save
		else
			render json: ['Unable to update tour']
		end
	end

	def destroy
		Tour.find(params[:id]).destroy
		render json: ['Successfully deleted tour'], status: 200
	end

	def create
		@tour = Tour.new(tour_params)
		return redirect_to @tour if @tour.save
		redirect_to new_tour_path
	end

		private

	def tour_params
		params.require(:tour).permit(:name, :audience_id, :notes)
	end

	def delete_expired_sessions
		TourSession.destroy_all(['start_date + duration < ?', Date.current])
	end
end
