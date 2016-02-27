class ToursController < ApplicationController
	include RQRCode
	before_action :authenticate_user!
	def index
	  items = Tour.includes(:points)
	  @tours = []
	  items.each do |item|
	    @tours << {
	      id: item.id,
	      data: item.name,
	      delete_url: delete_tour_path(item),
	      show_url: tour_path(item) }
	  end
	  @audiences = Audience.all.map do |audience|
	  	  [audience.name, audience.id]
	  end
	  api_response(@tours)
	end

	def show
	  @tour = Tour.find(params[:id])
	  @audience = Audience.find(@tour.audience_id)
	  @tour_points = TourPoint.where('tour_id' => params[:id]).order('rank').map do |tp|
	  	{
	  			id: tp.point.id,
	  			name: tp.point.name,
	  			rank: tp.rank,
	  			show_url: point_path(tp.point),
	  			delete_url: delete_tour_point_path(tp),
	  			increase_url: increase_tour_point_path(tp),
	  			decrease_url: decrease_tour_point_path(tp),
	  			pdf_url: tour_pdf_path(tp)
	  		}
	  end
	  @tour_points = [] if @tour_points.nil?
	  items = [
		  tour: @tour,
		  audience: @audience,
			points:  @tour_points
	  ]
	  api_response(items)
	end

	def pdf
		@tour = Tour.find(params[:id])
		@audience = Audience.find(@tour.audience_id)
		@tour_points = TourPoint.where('tour_id' => params[:id]).order("rank").map do |tp|
	  		{
	  			id:tp.point.id,
	  			name:tp.point.name,
	  			rank:tp.rank,
	  			qr_code: QRCode.new("POINT-#{tp.point.id}",size: 3)
	  		}
		end
		render pdf: "#{@tour.name}"
	end

	def new
	  @tour = Tour.new
	  @audience_options = Audience.all.map do |audience|
			[audience.name, audience.id]
	  end
	end

	def edit
		@tour = Tour.find(params[:id])
		@audience_options = Audience.all.map do |audience|
			[audience.name, audience.id]
		end
	end

	def update
		@tour = Tour.find(params[:id])
		if @tour.update_attributes(tour_params)
			render json: ['Successfully updated tour'], status: 200 if @tour.save
		else
			render json: ['Unable to update tour']
		end
	end

	def destroy
		@tour = Tour.find(params[:id])
		@tour.destroy
		render json: ['Successfully deleted tour'], status: 200
	end

	def create
		@tour = Tour.new(tour_params)
		if @tour.save
			redirect_to @tour
		else
			redirect_to new_tour_path
		end
	end

		private

	def tour_params
	  params.require(:tour).permit(:name, :audience_id)
	end
end
