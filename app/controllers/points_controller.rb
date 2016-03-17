# Version 1.0
# Points Controller responsible for creating and manipulating
# point records that appear in tours
class PointsController < ApplicationController
	include RQRCode
	before_action :authenticate_user!

	# Prepare all point records for response via the
	# hiTour API
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

	# Create a Point record, saving it to the database
	# Ensure point has a cover photo file
	# Analyse the file uploaded to ensure it's of the
	# required format
	def create
		# Redirect back since no file provided
		return redirect_to points_path if params[:file].nil?
		# Extract file_name and file_path
		file_path = params[:file].path
		# Make sure the file is an image
		unless image?(file_path)
			flash[:failure] = 'File provided is not an image'
			return redirect_to points_path
		end
		file_extension = File.extname(file_path)
		params[:url] = analyse_upload(file_path, file_extension)
		@point = Point.new(name: params[:name],
																description: params[:description],
															 url: params[:url])
		@point.save
		flash[:success] = "Point (#{params[:name]}) succesfully created and uploaded"
		redirect_to points_path
	end

	# Show data for a particular point whose id matches that given in
	# the params
	# Include Urls to mutate rank and delete record
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

	# Update a given point whose id matches that given
	# in the params
	def update
		@point = Point.find(params[:id])
		if @point.update_attributes(point_params)
			render json: ['Successfully updated point'], status: 200
		else
			render json: ['Could not update point']
		end
	end

	# Delete a given point whose id matches that
	# given in the params
	def destroy
		TourPoint.where(point_id: params[:id]).destroy_all
		Point.destroy(params[:id])
		render json: ['Succesfully deleted point']
	end

		private

	# Require a record of type Point and permit the given attributes
	def point_params
		params.require(:point).permit(:name, :description, :url)
	end
end
