class DataController < ApplicationController
  before_action :authenticate_activate_user!

  require 'securerandom'
  require 'streamio-ffmpeg'
  require 'fastimage'

  def index
    @data = []
    items = Datum.all
    items.each do |item|
      datum = item.as_json
      datum['data'] = item.title
      datum['delete_url'] = delete_datum_path(item)
      datum['show_url'] = datum_path(item)
      @data << datum
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
    items = { datum: @datum, datum_audiences: datum_audiences }
    api_response(items)
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
    params[:url] = analyse_upload(file_path, file_extension)
    @datum = Datum.new(title: params[:title],
                       description: params[:description],
                       url: params[:url])
    @datum.save
    flash[:success] = "Media (#{params[:title]}) succesfully uploaded"
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
