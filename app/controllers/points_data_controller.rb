class PointsDataController < ApplicationController
	def new
		@point_datum = PointDatum.new
		@data_options = Datum.all.map{|data| [data.title,data.id]}
		@point_options = Point.all.map{|point| [point.name,point.id]}
	end

	def create 
		@point_datum = PointDatum.new(point_datum_params)
		if @point_datum.save
			redirect_to controller: "points",action: 'show',id: @point_datum.point_id
		else
			redirect_to new_points_data_path
		end
	end

	private 
	def point_datum_params
		params.require(:point_datum).permit(:point_id,:datum_id)
	end
end
