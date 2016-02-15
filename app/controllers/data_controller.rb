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
    # Extract filename and filepath
    fileName = params[:file].original_filename
    filePath = params[:file].path
    # Add FilePath to the params
    params[:url] = uploadToS3 fileName,filePath

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


  def uploadToS3 fileName,filePath
    s3 = Aws::S3::Resource.new
    obj = s3.bucket('hitourbucket').object(fileName)
    obj.upload_file(filePath,acl: 'public-read')
    return obj.public_url
  end

  private 
  def datum_params
  	params.permit(:title,:description,:url)
  end
end
