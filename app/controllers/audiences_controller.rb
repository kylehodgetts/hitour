class AudiencesController < ApplicationController
	def index
		@audiences = Audience.all
	end

	def new 
		@audience = Audience.new
	end

	def create
		@audience = Audience.new(audience_params)
		if @audience.save
			redirect_to audiences_path
		else
			redirect_to new_audience_path
		end
	end

	private
	def audience_params
		params.require(:audience).permit(:name)
	end
end
