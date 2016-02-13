class ToursAudiencesController < ApplicationController
	def new
		@tour_audience = TourAudience.new
		@data_options = []
		@tour_options = Tour.all.map{|tour| [tour.name,tour.id]}
		@audience_options = Audience.all.map{|audience| [audience.name,audience.id]}
	end

	def create 
		@tour_Audience = TourAudience.new(tour_audience_params)
		if @tour_Audience.save
			redirect_to controller: "tours",action: 'show',id: @tour_Audience.tour_id
		else
			redirect_to new_tours_audiences_path
		end
	end

	private 
	def tour_audience_params
		params.require(:tour_audience).permit(:tour_id,:audience_id)
	end

end
