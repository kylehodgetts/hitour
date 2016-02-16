class DataAudiencesController < ApplicationController
  before_action :authenticate_user!

  def new
  @data_audience = DataAudience.new
		@data_options = []
		@data_options << [params[:datum_title], params[:datum_id]]
		@audience_options = Audience.all.map do |audience|
			[audience.name, audience.id]
		end
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
		params.require(:data_audience).permit(:datum_id, :audience_id)
  end
end
