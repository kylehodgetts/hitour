class PointsController < ApplicationController

		def index
			@points = Point.all
			@datums = Datum.all
			@point_datums = PointDat.all
		end

		def show
			@point = Point.find(params[:id])
		end

		def new 
			@point = Point.new
		end

		def create
			unless Point.find_by(name: params[:name])
				@point = Point.new(point_params)
				if @point.save
					redirect_to @point
				else
					redirect_to new_point_path
				end
			else
				render new
			end
		end

		private 
		def point_params
			params.require(:point).permit(:name)
		end

end
