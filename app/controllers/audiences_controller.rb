class AudiencesController < ApplicationController
	def index
		@audiences = Audience.all
	end

	def show
		puts "Requested show of audience"
		@audience = Audience.find(params[:id])
	end

	def edit
		puts "Requested edit of audience"
		@audience = Audience.find(params[:id])
	end

	def update
		puts "Request update of audience"
		@audience = Audience.find(params[:id])
		if @audience.update_attributes(audience_params)
			redirect_to @audience
		else
			redirect_to edit_audience_path
		end
	end

	def new 
		puts "Requested new audience"
		@audience = Audience.new
	end

	def create
		puts "Request creation of audience"
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
