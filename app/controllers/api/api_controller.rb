module Api
  class ApiController < ApplicationController
    before_action :api_authenticate!

    def tours
      response = {}
      response['tours'] = Tour.all.as_json
      response['tours'].each do |tour|
        populate_tour_reponse(tour)
      end

      render json: response
    end

    def single_tour
      response = Tour.find(params[:id]).as_json
      response = populate_tour_reponse(response)
      render json: response
    end

    private

    def populate_tour_reponse(tour)
      tour['points'] = TourPoint.where(tour_id: tour['id']).as_json
      tour['points'].each do |point|
        pd = PointDatum.where(point_id: point['id']).as_json
        point['data'] = []
        pd.each do |point_datum|
          populate_data_reponse(tour, point, point_datum)
        end
      end
    end

    def populate_data_reponse(tour, point, point_datum)
      data = Datum.where(id: point_datum['datum_id'])
      data.each do |datum|
        audiences = datum.audiences
        audiences.each do |audience|
          if audience.id == tour['audience_id']
            point['data'] << datum
            break
          end
        end
      end
    end
  end
end
