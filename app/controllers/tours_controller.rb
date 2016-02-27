class ToursController < ApplicationController
	before_action :authenticate_user!
	def index
	  items = Tour.includes(:points)
	  @tours = []
	  items.each do |item|
	    @tours << {
	      id: item.id,
	      data: item.name,
	      delete_url: delete_tour_path(item),
	      show_url: tour_path(item) }
	  end
	  @audiences = Audience.all.map do |audience|
	  	  [audience.name, audience.id]
	  end
	  api_response(@tours)
	end

	def show
	  @tour = Tour.find(params[:id])
	  @audience = Audience.find(@tour.audience_id)
	  @tour_points = TourPoint.where('tour_id' => params[:id]).order('rank').map do |tp|
	  	{
	  			id: tp.point.id,
	  			name: tp.point.name,
	  			rank: tp.rank,
	  			show_url: point_path(tp.point),
		  		delete_url: delete_tour_point_path(tp),
		  		increase_url: increase_tour_point_path(tp),
		  		decrease_url: decrease_tour_point_path(tp)
			}
	  end
	  @tour_points = [] if @tour_points.nil?
	  items = [
		  tour: @tour,
		  audience: @audience,
			points:  @tour_points
	  ]
	  api_response(items)
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
		@tour.name = params[:name]
		render json: ['Successfully updated tour'], status: 200 if @tour.save
	end

	def destroy
		@tour = Tour.find(params[:id])
		@tour.destroy
		render json: ['Successfully deleted tour'], status: 200
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
