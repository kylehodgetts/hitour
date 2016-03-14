class DataAudiencesController < ApplicationController
  before_action :authenticate_user!
	before_action :activate_user!
  
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
    begin
		  @data_audience.save
    render json: ['Succesfully linked audience to media']
		rescue ActiveRecord::RecordNotUnique
      render json: ['This audience has already been added to this datum']
		end
  end

  def destroy
  	@data_audience = DataAudience.find(params[:id])
  	if @data_audience.destroy
  		render json: ['Succesfully deleted link between data and audience']
  	else
  		render json: ['Couldnt delete link between data and audience']
  	end
  end

  private

  def data_audience_params
		params.require(:data_audience).permit(:datum_id, :audience_id)
  end
end
