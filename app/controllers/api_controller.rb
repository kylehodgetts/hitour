class ApiController < ApplicationController

	def fetch
		access_key = params[:access_key]
		table_name = params[:table_name]
		if is_valid_api_key?access_key
			render json: fetch_data(table_name)
		else
			render json: "API Access Key Invalid"
		end
	end

	def fetch_data(table_name)
		case table_name
		when 'audiences'
			return Audience.all
		when 'dataaudiences'
			return DataAudience.all
		when 'data'
			return Datum.all
		when 'points'
			return Point.all
		when 'pointdata'
			return PointDatum.all
		when 'tours'
			return Tour.all
		when 'tourpoints'
			return TourPoint.all
		else
			return "No Matching Table"
		end 
	end

	# Checks if api access key matches key in environment variable
	def is_valid_api_key?(access_key)
	  return (access_key == ENV['API_ACCESS_KEY'])
	end

end
