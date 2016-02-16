module Api
  class ApiController < ApplicationController
    before_action :api_authenticate!
    def audiences
      render json: Audience.all
    end

    def tours
      render json: Tour.all
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
