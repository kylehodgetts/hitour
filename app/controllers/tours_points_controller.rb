class ToursPointsController < ApplicationController
	
  def new
		@tour_point = TourPoint.new
		@tour_options = Tour.all.map{|tour| [tour.name,tour.id]}
		@point_options = Point.all.map{|point| [point.name,point.id]}
  end

	def create 
		@tour_point = TourPoint.new(point_data_params)
		if @tour_point.save
			redirect_to controller: "tours",action: 'show',id: @tour_point.tour_id
		else
			redirect_to new_tours_points_path
		end
	end

	def destroy
		@tour_point = TourPoint.find_by tour_id: params[:tour_id], point_id: params[:point_id]
		@tour_point.destroy
		redirect_to controller: "tours",action: 'show',id: @tour_point.tour_id
  	end
	private 
	def point_data_params
		params.require(:tour_point).permit(:tour_id,:point_id)
	end
end
