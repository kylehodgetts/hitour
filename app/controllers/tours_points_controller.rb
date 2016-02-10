class ToursPointsController < ApplicationController
  def new
		@tour_point = TourPoint.new
		@tour_options = Tour.all.map{|tour| [tour.name,tour.id]}
		@point_options = Point.all.map{|point| [point.name,point.id]}
	end

	def create 
		@tour_point = TourPoint.new(point_data_params)
		if @tour_point.save
			redirect_to tour_path
		else
			redirect_to new_tours_points_path
		end
	end

	private 
	def point_data_params
		params.require(:tour_point).permit(:tour_id,:point_id)
	end
end
