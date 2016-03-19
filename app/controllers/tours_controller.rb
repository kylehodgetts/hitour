# Version 1.0
# Tours Controller responsible for creating and manipulating
# tour records
class ToursController < ApplicationController
	include ToursHelper
	include RQRCode
	before_action :authenticate_user!

	# Prepare all tour records for response via the
	# hiTour API
	def index
		items = Tour.includes(:points)
		@tours = []
		items.each do |item|
			@tours << item.as_json.merge(
			  data: item.name,
			  delete_url: tour_path(item),
			  show_url: tour_path(item)
			)
		end
		@audiences = Audience.all.map do |audience|
			[audience.name, audience.id]
		end
		api_response(@tours)
	end

	# Show data for a particular tour whose id matches that given in
	# the params
	# Include associations for the tour
	# Delete all expired sessions
	def show
		delete_expired_sessions
		@tour = Tour.includes(:tour_sessions).find(params[:id])
		@audiences = Audience.all
		@audience = Audience.find(@tour.audience_id)
		@tour_points = tour_points(params[:id])
		@tour_sessions = tour_sessions(@tour)
		@tour_points = [] if @tour_points.nil?
		average = @tour.feedbacks.average(:rating)
		average.round(2) if average
		items = [
		  tour: 				 @tour,
			 currentQuiz:  quiz_data(@tour.id),
		  audience:			 @audience,
		  points:  			 @tour_points,
			 tour_sessions: @tour_sessions,
			 feedbacks: tour_feedbacks,
			 feedbackAverage: average,
			 quizzes: Quiz.all.as_json
		]
		api_response(items)
	end

	# Create a Tour record, saving it to the database
	# Return a success message, if record is saved
	# Otherwise, return an error message
	def create
		@tour = Tour.new(tour_params)
		return render json: ['Successfully created tour'] if @tour.save
		render json: ['Couldnt create tour']
	end

	# Update a given tour whose id matches that
	# given in the params
	# Return a success message, if record is updated
	# Otherwise, return an error message
	def update
		@tour = Tour.find(params[:id])
		if @tour.update_attributes(tour_params)
			render json: ['Successfully updated tour'], status: 200 if @tour.save
		else
			render json: ['Unable to update tour']
		end
	end

	# Destroy the tour whose id matches that
	# given in the params
	def destroy
		Tour.find(params[:id]).destroy
		render json: ['Successfully deleted tour'], status: 200
	end

	# Return all the quiz data for a given tour_id
	# return an empty array if the tour does not have
	# an associated quiz
	def quiz_data(tour_id)
		tour_quiz = TourQuiz.where(tour_id: tour_id).first
		return [] if tour_quiz.nil?
		Quiz.find(tour_quiz.quiz_id).as_json.merge(
				delete_url: remove_tour_quiz_path(tour_quiz[:id])
		)
	end

	# Fetches all the tour sessions for a given tour
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

	# Fetches all the tour feedback records submitted
	# for the given tour
	def tour_feedbacks
		@tour.feedbacks.map do |feedback|
			feedback.as_json.merge(
					created_at: feedback.created_at.to_formatted_s(:long),
					delete_url: feedback_path(feedback)
			)
		end
	end

	# Render a PDF of all the tours data
	def pdf
		@tour = Tour.find(params[:id])
		@audience = Audience.find(@tour.audience_id)
		@tour_points = tour_points(params[:id])
		@tour_sessions = tour_sessions(@tour)
		render pdf: @tour.name.to_s
	end

	# Fetches all the Points for a given tour
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

		private

	# Require a record of type Tour and permit the given attributes
	def tour_params
		params.require(:tour).permit(:name, :audience_id, :notes)
	end
end
