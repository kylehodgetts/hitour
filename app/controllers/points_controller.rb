class PointsController < ApplicationController
	include RQRCode
	before_action :authenticate_user!
	def index
		@points = Point.includes(:data)
		@points_qr = []
		@points.each do |point|
			@points_qr[point.id] = QRCode.new('#{point.id.to_s} - #{point.name}')
		end
		@points_json = []
		@points.each do |item|
			@points_json << {
			  id: item.id,
			  data: item.name,
			  delete_url: delete_point_path(item),
			  show_url: point_path(item)
			}
		end
		api_response(@points_json)
	end

	def show
		@point = Point.includes(:data).find(params[:id])
		point_data = PointDatum.where(point_id: params[:id]).order('rank').map do |pd|
		{
				id:	pd.id,
				title: pd.datum.title,
				url: pd.datum.url,
				rank: pd.rank,
				description: pd.datum.description,
				audiences: pd.datum.audiences,
				datum_show_url: datum_path(pd.datum),
				delete_url: delete_points_data_path(pd),
				increase_url: increase_point_datum_path(pd),
				decrease_url: decrease_point_datum_path(pd)
		}
		end
		items = {
		  point: @point,
		  point_data: point_data,
		  qr_code: QRCode.new("POINT-#{@point.id}", size: 3).as_svg
		}
		api_response(items)
	end

	def update
		@point = Point.find(params[:id])
		if @point.update_attributes(point_params)
			render json: ['Successfully updated point'], status: 200
		else
			render json: ['Could not update point']
		end
	end

	def destroy
		@point = Point.find(params[:id])
		@point.destroy
		render json: ['Succesfully deleted point']
	end

	def create
		# Redirect back since no file provided
		return redirect_to points_path if params[:file].nil?
		# Extract file_name and file_path
		file_path = params[:file].path
		file_extension = File.extname(file_path)

		# Add file_path to the params
		params[:url] = upload_to_s3 file_extension, file_path

		@point = Point.new(
		  name: params[:name],
		  description: params[:description],
		  url: params[:url]
		)
		@point.save
		redirect_to points_path
	end

		private

	def point_params
		params.require(:point).permit(:name, :description, :url)
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
