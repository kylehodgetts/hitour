class DataAudiencesController < ApplicationController
	def new
		@data_audience = DataAudience.new
	end

	def create 
		@data_audience = DataAudience.new
	end

	private 
	def data_audience_params
		params.require(:data_audience).permit(:data_id,:audience_id)
	end

end
