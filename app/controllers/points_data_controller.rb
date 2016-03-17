class PointsDataController < ApplicationController
	before_action :authenticate_user!

	def create
		point = Point.find(params[:point_datum][:point_id])
		params[:point_datum][:rank] = max_rank(point)
		begin
			@point_datum = PointDatum.new(point_datum_params)
			if @point_datum.save
				render json: ['Succesfully added media to point']
			else
	      render json: [@point_datum.errors.full_messages.first]
			end
		rescue ActiveRecord::RecordNotUnique
			render json: ['This media has already been added to this point']
		end
	end

	def destroy
	  	@point_datum = PointDatum.find(params[:id])
			 # Update ranks of other tour_points
			 PointDatum.where(point_id: @point_datum.point.id).each do |pd|
 				if pd.rank.to_i > @point_datum.rank.to_i
 					pd.rank = pd.rank - 1
 					pd.save
 				end
 			end
	  	@point_datum.destroy
				render json: ['Succesfully deleted datum from point']
	end

	def increase_rank
		point_datum = PointDatum.find(params[:id])
		if update_rank(point_datum, point_datum.rank + 1)
			render json: ["Succesfully moved #{point_datum.datum.title} down"]
		else
			render json: ['Couldnt increase rank']
		end
	end

	def decrease_rank
		point_datum = PointDatum.find(params[:id])
		if update_rank(point_datum, point_datum.rank - 1)
			render json: ["Succesfully moved #{point_datum.datum.title} up"]
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
	def max_rank(point)
		point = Point.find(point.id)
		rank = PointDatum.where(point_id: point.id).maximum(:rank)
		rank.to_i + 1
	end

	def update_rank(point_datum, new_rank)
		updated = false
		PointDatum.where(point_id: point_datum.point.id).each do |pd|
			next if pd.rank != new_rank
			pd.rank = point_datum.rank
			point_datum.rank = new_rank
			pd.save
			point_datum.save
			updated = true
			break
		end
		updated
	end
end
