class PointsController < ApplicationController

		def index
			@points = Point.includes(:data)
		end

		def show
			@point = Point.find(params[:id])
			@qrcode = RQRCode::QRCode.new(@point.id.to_s+"-"+@point.name)
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
