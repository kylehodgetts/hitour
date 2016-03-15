class ToursPointsController < ApplicationController
	before_action :authenticate_activate_user!

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

	def increase_rank
		tour_point = TourPoint.find(params[:id])
		if update_rank(tour_point, tour_point.rank + 1)
			render json: ["Succesfully increased rank to #{tour_point.rank}"]
		else
			render json: ['No change in rank']
		end
	end

	def decrease_rank
		tour_point = TourPoint.find(params[:id])
		if update_rank(tour_point, tour_point.rank - 1)
			render json: ["Succesfully decreased rank to #{tour_point.rank}"]
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
		rank = TourPoint.where('tour_id' => tour.id).maximum('rank')
		rank.to_i + 1
	end

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
