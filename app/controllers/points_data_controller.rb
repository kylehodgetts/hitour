# Version 1.0
# Points Data Controller responsible for creating and maintaining
# Point Data relationships
class PointsDataController < ApplicationController
	before_action :authenticate_user!

	# Save a Point Data pair to the database
	# Raise a RecordNotUnique exception if a relationship already exists
	# between a given Point and Datum
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

	# Destroy a Point Data pair whose relationship record
	# matches the given id.
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

	# Increase the rank of the Point Datum by 1
	# which will decrease the Point Datum below by 1
	# The effect will the Datum will appear one slot later
	# in the point
	def increase_rank
		point_datum = PointDatum.find(params[:id])
		if update_rank(point_datum, point_datum.rank + 1)
			render json: ["Succesfully moved #{point_datum.datum.title} down"]
		else
			render json: ['Couldnt increase rank']
		end
	end

	# Decrease the rank of the Point Datum by 1
	# which will increase the Point Datum above by 1
	# The effect will the Datum will appear one slot earlier
	# in the point
	def decrease_rank
		point_datum = PointDatum.find(params[:id])
		if update_rank(point_datum, point_datum.rank - 1)
			render json: ["Succesfully moved #{point_datum.datum.title} up"]
		else
			render json: ['Couldnt decrease rank']
		end
	end

		private

	# Require a record of type Point Datum and permit the given attributes
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

	# Assigns the given point datum the given rank
	# returns true if the record is updated, false otherwise
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
