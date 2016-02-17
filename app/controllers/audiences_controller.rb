class AudiencesController < ApplicationController
  before_action :authenticate_user!
  def index
    @audiences = Audience.all
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

  private

  def audience_params
    params.require(:audience).permit(:name)
  end
end
