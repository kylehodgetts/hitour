class DataController < ApplicationController
  before_action :authenticate_user!
  def index
  	@data = Datum.all
  end

  def show
  	@datum = Datum.includes(:audiences).find(params[:id])
  end

  def edit
    @datum = Datum.find(params[:id])
  end

  def update
    @datum = Datum.find(params[:id])
    if @datum.update_attributes(datum_params)
      redirect_to @datum
    else
      render new
    end
  end

  def new
  	@data = Datum.new
  end

  def create
    # Extract file_name and file_path
    file_name = params[:file].original_file_name
    file_path = params[:file].path
    # Add file_path to the params
    params[:url] = uploadToS3 file_name, file_path

    @datum = Datum.new(datum_params)
    if @datum.save
  		redirect_to @datum
    else
  		render new
    end
  end

  def destroy
    @datum = Datum.find(params[:id])
    @datum.destroy
    redirect_to data_path
  end

  def upload_to_s3(file_name, file_path)
    s3 = Aws::S3::Resource.new
    obj = s3.bucket('hitourbucket').object(file_name)
    obj.upload_file(file_path, acl: 'public-read')
    obj.public_url
  end

  private

  def datum_params
  	params.permit(:title, :description, :url)
  end
end
