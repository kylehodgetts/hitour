class ToursController < ApplicationController

	def index
	  @tours = Tour.all
	end
	def new
	  @tour = Tour.new
	  @audience_options = Audience.all.map{|audience| [audience.name,audience.id]}
	end

	def create
			unless Tour.find_by(name: params[:name])
				@tour = Tour.new(tour_params,audience_params)
				if @tour.save
					redirect_to @tour
				else
					redirect_to new_tour_path
				end
			else
				render new
			end
		end

	private 
	def tour_params
	  params.require(:tour).permit(:name,:audience_id)
	end
end
