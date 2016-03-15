# Version 1.0
# Data Audience Controller responsible for creating and maintaining
# Data Audience relationships
class DataAudiencesController < ApplicationController
  before_action :authenticate_user!

  # Create a new Data Audience pair denoting that a data
  # is available to a given audience
  def new
    @data_audience = DataAudience.new
    @data_options = []
    @data_options << [params[:datum_title], params[:datum_id]]
    @audience_options = Audience.all.map do |audience|
			[audience.name, audience.id]
    end
  end

  # Save a Data Audience pair to the database
  # Raise a RecordNotUnique exception if a relationship already exists
  # between a given data and audience
  def create
    @data_audience = DataAudience.new(data_audience_params)
    begin
		  @data_audience.save
    render json: ['Succesfully linked audience to media']
		rescue ActiveRecord::RecordNotUnique
      render json: ['This audience has already been added to this datum']
		end
  end

  # Destroy a Data Audience pair whose relationship record
  # matches the given id.
  def destroy
  	@data_audience = DataAudience.find(params[:id])
  	if @data_audience.destroy
  		render json: ['Succesfully deleted link between data and audience']
  	else
  		render json: ['Couldnt delete link between data and audience']
  	end
  end

  private

  # Require a record of type DataAudience
  # permitting the given attributes
  def data_audience_params
		params.require(:data_audience).permit(:datum_id, :audience_id)
  end
end
