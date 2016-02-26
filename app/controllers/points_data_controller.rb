class PointsDataController < ApplicationController
	before_action :authenticate_user!
	def new
		@point_datum = PointDatum.new
		@point_id = params[:point_id]
		@point_name = params[:point_name]
		@data_options = Datum.all.map { |data| [data.title, data.id] }
	end

	def create
		@point_datum = PointDatum.new(point_datum_params)
		if @point_datum.save
			redirect_to controller: 'points', action:	'show', id: @point_datum.point_id
		else
			redirect_to new_points_data_path
		end
	end

	def edit
		@point_datum = PointDatum.find_by(point_id: params[:point_id],
																			datum_id: params[:datum_id])
	end

	def update
		@point_datum = PointDatum.find_by(point_id: params[:point_datum][:point_id],
																			datum_id: params[:point_datum][:datum_id])
		if @point_datum.update_attributes(point_datum_params)
			redirect_to Point.find_by(params[:point_id])
		else
			redirect_to edit_point_datum_path
		end
	end

	def destroy
	  @point_datum = PointDatum.find(params[:id])
	  @point_datum.destroy
		render json: ['Succesfully deleted datum from point']
	end

	def increase_rank
		point_datum = PointDatum.find(params[:id])
		# Check if tour point has rank + 1
		# If so - swap them
		updated = false
		PointDatum.where('point_id' => point_datum.point.id).each do |pd|
			if pd.rank == point_datum.rank + 1
				pd.rank = point_datum.rank
				point_datum.rank = point_datum.rank + 1
				pd.save
				point_datum.save
				updated = true
				break
			end
		end
		if updated
			render json: ["Succesfully increased rank to #{point_datum.rank}"]
		else
			render json: ['Couldnt increase rank']
		end
	end

	def decrease_rank
		point_datum = PointDatum.find(params[:id])
		# Check if tour point has rank - 1
		# If so - swap them
		updated = false
		PointDatum.where('point_id' => point_datum.point.id).each do |pd|
			if pd.rank == point_datum.rank - 1
				pd.rank = point_datum.rank
				point_datum.rank = point_datum.rank - 1
				pd.save
				point_datum.save
				updated = true
				break
			end
		end
		if updated
			render json: ["Succesfully decreased rank to #{point_datum.rank}"]
		else
			render json: ['Couldnt decrease rank']
		end
	end

		private

	def point_datum_params
		params.require(:point_datum).permit(:point_id, :datum_id, :rank)
	end

	# Returns the max rank for
	# Specific Point
	def max_rank(point_id)
		point = Point.find(point_id)
		rank = PointDatum.where('point_id' => point.id).maximum('rank')
		rank.to_i + 1
	end
end
