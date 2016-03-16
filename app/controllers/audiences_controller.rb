# Version 1.0
# Audiences Controller responsible for RESTful actions
# with respect to the Audience Records
class AudiencesController < ApplicationController
  before_action :authenticate_user!

  # Return all audiences to view with the responsible
  # response format
  def index
    items = Audience.all
    @audiences = []
    items.each do |item|
      @audiences << {
        id: item.id,
        data: item.name,
        delete_url: delete_audience_path(item) }
    end
    api_response(@audiences)
  end

  # Create an audience with the given parameters
  # If the record is saved, redirect to the index action
  def create
    @audience = Audience.new(audience_params)
    return render json: ['Successfully created audience'] if @audience.save
    render json: ['Couldnt create audience']
  end

  # Destroy an audience with the given ID
  # Only if no tour references this record as its audience
  def destroy
    if Tour.find_by(audience_id: params[:id])
      render json: ['Cannot delete Audience while a Tour has it assigned'],
             status: 200
    else
      DataAudience.where(audience_id: params[:id]).destroy_all
      Audience.destroy(params[:id])
      render json: ['Successfully deleted audience'], status: 200
    end
  end

  private

  # Require a record of time audience with the name attribute
  def audience_params
    params.require(:audience).permit(:name)
  end
end
