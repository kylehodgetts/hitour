class PointsDataController < ApplicationController
	def new
		@point_data = PointDatum.new
		@data_options = Datum.all.map{|data| [data.title,data.id]}
		@point_options = Point.all.map{|point| [point.name,point.id]}
	end

	def create 
		@point_data = PointDatum.new(point_data_params)
		if @point_data.save
			redirect_to point_path
		else
			redirect_to new_points_data_path
		end
	end

	private 
	def point_data_params
		params.require(:point_data).permit(:point_id,:data_id)
	end
end
