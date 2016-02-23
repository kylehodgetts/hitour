class ToursPointsController < ApplicationController
	before_action :authenticate_user!
	def new
		@tour_point = TourPoint.new
		@tour_options = Tour.all.map do |tour|
			[tour.name, tour.id]
		end
		@point_options = Point.all.map do |point|
			[point.name, point.id]
		end
	end

	def create
		@tour_point = TourPoint.new(point_data_params)
		if @tour_point.save
			render json: ['Succesfully added link between tour and point']
		else
			render json: ['There was an issue adding the point to the tour']
		end
	end

	def destroy
		@tour_point = TourPoint.find(params[:id])
		@tour_point.destroy
		render json: ['Succesfully deleted link between tour and point']
	end

	def increase_rank
		tour_point = TourPoint.find(params[:id])
		# Check if tour point has rank + 1
		# If so - swap them
		updated = false
		TourPoint.where('tour_id' => tour_point.tour.id).each do |tp|
			if tp.rank == tour_point.rank + 1
				tp.rank = tour_point.rank
				tour_point.rank = tour_point.rank + 1
				tp.save
				tour_point.save
				updated = true
				break
			end
		end
		if updated
			render json: ["Succesfully increased rank to #{tour_point.rank}"]
		else
			render json: ['No change in rank']
		end
	end

	def decrease_rank
		tour_point = TourPoint.find(params[:id])
		# Check if tour point has rank - 1
		# If so - swap them
		updated = false
		TourPoint.where('tour_id' => tour_point.tour.id).each do |tp|
			if tp.rank == tour_point.rank - 1
				tp.rank = tour_point.rank
				tour_point.rank = tour_point.rank - 1
				tp.save
				tour_point.save
				updated = true
				break
			end
		end
		if updated
			render json: ["Succesfully decreased rank to #{tour_point.rank}"]
		else
			render json: ['Couldnt update rank']
		end
	end

		private

	def point_data_params
		params.require(:tour_point).permit(:tour_id, :point_id, :rank)
	end
end
