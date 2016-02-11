class ToursController < ApplicationController

	def index
	  @tours = Tour.all
	end

	def show
	  @tour = Tour.find(params[:id])
	end

	def new
	  @tour = Tour.new
	  @audience_options = Audience.all.map{|audience| [audience.name,audience.id]}
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
	  params.require(:tour).permit(:name,:audience_id)
	end
end
