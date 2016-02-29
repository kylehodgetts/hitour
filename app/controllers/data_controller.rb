class DataController < ApplicationController
  before_action :authenticate_user!
  require 'securerandom'

  def index
    @data = []
    items = Datum.all
    items.each do |item|
      @data << {
        id: item.id,
        data: item.title,
        title: item.title,
        description: item.description,
        url: item.url,
        delete_url: delete_datum_path(item),
        show_url: datum_path(item)
      }
    end
    api_response(@data)
  end

  def show
    @datum = Datum.includes(:audiences).find(params[:id])
    datum_audiences = DataAudience.where(datum_id: params[:id]).map do |da|
      {
        id: da.id,
        data: da.audience.name,
        delete_url: delete_datum_audience_path(da)
      }
    end
    items = {
      datum: @datum,
      datum_audiences: datum_audiences
    }
    api_response(items)

    # @datum = Datum.includes(:audiences).find(params[:id])
  end

  def edit
    @datum = Datum.find(params[:id])
  end

  def update
    @datum = Datum.find(params[:id])
    if @datum.update_attributes(datum_params)
      render json: ['Successfully updated media'], status: 200
    else
      render json: ['Unable to update media ' + params[:datum][:title]]
    end
  end

  def new
    @data = Datum.new
  end

  def create
    # Redirect back since no file provided
    return redirect_to data_path if params[:file].nil?
    # Extract file_name and file_path
    file_path = params[:file].path
    file_extension = File.extname(file_path)
    # Add file_path to the params
    params[:url] = upload_to_s3 file_extension, file_path

    @datum = Datum.new(datum_params)
    @datum.save
    redirect_to data_path
  end

  def destroy
    @datum = Datum.find(params[:id])
    @datum.destroy
    render json: ["Succesfully deleted #{@datum.title}"]
  end

  private

  def datum_params
    params.require(:datum).permit(:title, :description, :url)
  end
end
