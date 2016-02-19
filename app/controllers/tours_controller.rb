class ToursController < ApplicationController
	before_action :authenticate_user!
	def index
	  @tours = Tour.all
		api_response(@tours)
	end

	def show
	  @tour = Tour.includes(:points).find(params[:id])
	  @audience = Audience.find(@tour.audience_id)
	  @tour_points = TourPoint.where('tour_id' => params[:id])
	end

	def new
	  @tour = Tour.new
	  @audience_options = Audience.all.map do |audience|
			[audience.name, audience.id]
	  end
	end

	def edit
		@tour = Tour.find(params[:id])
		@audience_options = Audience.all.map do |audience|
			[audience.name, audience.id]
		end
	end

	def update
		@tour = Tour.find(params[:id])
		if @tour.update_attributes(tour_params)
			redirect_to @tour
		else
			redirect_to new_tour_path
		end
	end

	def destroy
		@tour = Tour.find(params[:id])
		@tour.destroy
		redirect_to tours_path
	end

	def create
		@tour = Tour.new(tour_params)
		if @tour.save
			redirect_to @tour
		else
			redirect_to new_tour_path
		end
	end

		private

	def tour_params
	  params.require(:tour).permit(:name, :audience_id)
	end
end
