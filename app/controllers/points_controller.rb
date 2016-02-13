class PointsController < ApplicationController

		def index
			@points = Point.includes(:data)
			@points_qr = []
			@points.each do |point|
				@points_qr[point.id] = RQRCode::QRCode.new(point.id.to_s+"-"+point.name)
			end
		end

		def show
			@point = Point.includes(:data).find(params[:id])
			@data_audiences = Datum.includes(:audiences)
			@qrcode = RQRCode::QRCode.new(@point.id.to_s+"-"+@point.name)
			
		end

		def edit
			@point = Point.find(params[:id])
		end

		def update
			@point = Point.find(params[:id])
		    if @point.update_attributes(point_params)
		      redirect_to @point
		    else
		      render new
		    end
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
