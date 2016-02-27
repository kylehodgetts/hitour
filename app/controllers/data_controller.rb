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
    @datum.description = params[:name]
    render json: ['Successfully updated description'], status: 200 if @datum.save
  end

  def new
  	@data = Datum.new
  end

  def create
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

  def upload_to_s3(file_extension, file_path)
    s3 = Aws::S3::Resource.new
    obj = s3.bucket('hitourbucket').object(SecureRandom.hex + file_extension)
    obj.upload_file(file_path, acl: 'public-read')
    obj.public_url
  end

  private

  def datum_params
  	params.permit(:title, :description, :url)
  end
end
