class AudiencesController < ApplicationController
  before_action :authenticate_user!
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

  def show
    @audience = Audience.find(params[:id])
  end

  def edit
    @audience = Audience.find(params[:id])
  end

  def update
    @audience = Audience.find(params[:id])
    if @audience.update_attributes(audience_params)
      redirect_to @audience
    else
      redirect_to edit_audience_path
    end
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

  def destroy
    audience = Audience.find(params[:id])
    audience.destroy
    render json: 'Successfully deleted audience', status: 200
  end

  private

  def audience_params
    params.require(:audience).permit(:name)
  end
end
