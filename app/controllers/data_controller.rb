  class DataController < ApplicationController
  def index
  	@data = Datum.all
  end

  def show
  	@datum = Datum.find(params[:id])
    @audiences = DataAudience.where(data_id: params[:id])
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
