# Version 1.0
# Tour Points Controller responsible for creating and maintaining
# Tour Point relationships
class ToursPointsController < ApplicationController
	before_action :authenticate_user!

	# Save a Tour Point pair to the database
	# Raise a RecordNotUnique exception if a relationship already exists
	# between a given Tour and Point
	def create
		tour_id = params[:tour_point][:tour_id]
		params[:tour_point][:rank] = max_rank(Tour.find(tour_id))
		begin
			@tour_point = TourPoint.new(point_data_params)
			@tour_point.save
			render json: ['Succesfully added link between tour and point']
		rescue ActiveRecord::RecordNotUnique
			render json: ['This point has already been added to this tour']
		end
	end

	# Destroy a Tour Point pair whose relationship record
	# matches the given id.
	def destroy
		@tour_point = TourPoint.find(params[:id])
		# Update ranks of other tour_points
		TourPoint.where(tour_id: @tour_point.tour.id).each do |tp|
			if tp.rank.to_i > @tour_point.rank.to_i
				tp.rank = tp.rank - 1
				tp.save
			end
		end
		@tour_point.destroy
		render json: ['Succesfully deleted link between tour and point']
	end

	# Increase the rank of the Tour Point by 1
	# which will decrease the Tour Point below by 1
	# The effect will the Point will appear one slot later
	# in the Tour
	def increase_rank
		tour_point = TourPoint.find(params[:id])
		if update_rank(tour_point, tour_point.rank + 1)
			render json: ["Succesfully moved #{tour_point.point.name} down"]
		else
			render json: ['No change in rank']
		end
	end

	# Decrease the rank of the Tour Point by 1
	# which will increase the Tour Point above by 1
	# The effect will the Point will appear one slot earlier
	# in the Tour
	def decrease_rank
		tour_point = TourPoint.find(params[:id])
		if update_rank(tour_point, tour_point.rank - 1)
			render json: ["Succesfully moved #{tour_point.point.name} up"]
		else
			render json: ['Couldnt update rank']
		end
	end

		private

	def point_data_params
		params.require(:tour_point).permit(:tour_id, :point_id, :rank)
	end

	# Returns the max rank for
	# Specific Tour
	def max_rank(tour_id)
		tour = Tour.find(tour_id)
		rank = TourPoint.where(tour_id: tour.id).maximum(:rank)
		rank.to_i + 1
	end

	# Assigns the given Tour Point the given rank
	# returns true if the record is updated, false otherwise
	def update_rank(tour_point, new_rank)
		updated = false
		TourPoint.where(tour_id: tour_point.tour.id).each do |tp|
			next if tp.rank != new_rank
			tp.rank = tour_point.rank
			tour_point.rank = new_rank
			tp.save
			tour_point.save
			updated = true
			break
		end
		updated
	end
end
