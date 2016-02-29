class PointsDataController < ApplicationController
	before_action :authenticate_user!
	def create
		point = Point.find(params[:point_datum][:point_id])
		params[:point_datum][:rank] = max_rank(point)
		begin
			@point_datum = PointDatum.new(point_datum_params)
			@point_datum.save
			render json: ['Succesfully added media to point']
		rescue ActiveRecord::RecordNotUnique
			render json: ['This media has already been added to this point']
		end
	end

	def destroy
	  	@point_datum = PointDatum.find(params[:id])
	  	@point_datum.destroy
				render json: ['Succesfully deleted datum from point']
	end

	def increase_rank
		point_datum = PointDatum.find(params[:id])
		if update_rank(point_datum, point_datum.rank + 1)
			render json: ["Succesfully increased rank to #{point_datum.rank}"]
		else
			render json: ['Couldnt increase rank']
		end
	end

	def decrease_rank
		point_datum = PointDatum.find(params[:id])
		if update_rank(point_datum, point_datum.rank - 1)
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

	def update_rank(point_datum, new_rank)
		updated = false
		PointDatum.where(point_id: point_datum.point.id).each do |pd|
			if pd.rank == new_rank
				pd.rank = point_datum.rank
				point_datum.rank = new_rank
				pd.save
				point_datum.save
				updated = true
				break
			end
		end
		return updated
	end
end
