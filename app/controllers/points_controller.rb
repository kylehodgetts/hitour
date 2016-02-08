class PointsController < ApplicationController

		def index
			@points = Point.all
			@datums = Datum.all
			@point_datums = PointDat.all
		end
		def show
			@point = Point.find(params[:id])
		end

end
