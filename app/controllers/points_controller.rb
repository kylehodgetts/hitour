class PointsController < ApplicationController
	include RQRCode
	before_action :authenticate_user!
	def index
		@points = Point.includes(:data)
		@points_qr = []
		@points.each do |point|
			@points_qr[point.id] = QRCode.new('#{point.id.to_s} - #{point.name}')
		end
	end

	def show
		@point = Point.includes(:data).find(params[:id])
		@datum_ranks = PointDatum.where('point_id' => params[:id])
		@ranks = {}
		@datum_ranks.each do |datum_rank|
			@ranks[datum_rank.datum.id] = datum_rank.rank
		end
		@data_audiences = Datum.includes(:audiences)
		@qrcode = QRCode.new('#{@point.id.to_s} - #{@point.name}')
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
		if Point.find_by(name: params[:name])
			render new
		else
			create_point
		end
	end

		private

	def point_params
		params.require(:point).permit(:name)
	end

	def create_point
		@point = Point.new(point_params)
		if @point.save
			redirect_to @point
		else
			@message = 'The name of the point has already been taken.'
			redirect_to new_point_path
		end
	end
end
