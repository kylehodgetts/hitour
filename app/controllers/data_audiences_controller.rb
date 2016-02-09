class DataAudiencesController < ApplicationController
	def new
		@data_audience = DataAudience.new
		@data_options = Datum.all.map{|data| [data.title,data.id]}
		@audience_options = Audience.all.map{|audience| [audience.name,audience.id]}
	end

	def create 
		@data_audience = DataAudience.new(data_audience_params)
		if @data_audience.save
			redirect_to data_path
		else
			redirect_to new_data_audience_path
		end
	end

	private 
	def data_audience_params
		params.require(:data_audience).permit(:data_id,:audience_id)
	end

end
