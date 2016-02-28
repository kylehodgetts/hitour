module Api
  class ApiController < ApplicationController
    before_action :api_authenticate!

    def audiences
      render json: Audience.all
    end

    def tours
      response = {}
      response['tours'] = Tour.all.as_json
      response['tours'].each do |tour|
        tour['points'] = TourPoint.where(tour_id: tour['id']).as_json
        tour['points'].each do |point|
          point['data'] = PointDatum.where(point_id: point['id']).as_json
        end
      end

      render json: response
    end

    def tour
      response = Tour.find(params[:id]).as_json
      response['points'] = TourPoint.where(tour_id: response['id']).as_json
      response['points'].each do |point|
        point['data'] = PointDatum.where(point_id: point['id'])
      end
      render json: response
    end

    def points
      render json: Point.all
    end

    def data
      render json: Datum.all
    end

    def tour_points
      render json: TourPoint.all
    end

    def point_data
      render json: PointDatum.all
    end

    def data_audiences
      render json: DataAudience.all
    end
  end
end
