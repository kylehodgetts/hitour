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

    def tour_session
      tour_session = TourSession.find_by passphrase: params[:passphrase]
      if tour_session
        # Get Tour Information
        tour = Tour.find(tour_session.tour.id)
        tour_points = TourPoint.where tour_id: tour.id
        points = []
        tour_points.each do |tp|
          point = Point.find(tp.point.id)
          all_data = PointDatum.where point_id: point.id
          data = []
          all_data.each do |pd|
            datum = Datum.includes(:audiences).find(pd.datum.id)
            datum_json = datum.as_json
            datum_json[:audiences] = datum.audiences
            datum_json[:rank] = pd.rank
            data << datum_json
          end
          point = point.as_json
          point[:rank] = tp.rank
          point[:data] = data
          points << point
        end
        tour = tour.as_json
        tour[:points] = points
        render json: [
          tour_session: tour_session,
          tour: tour
        ]
      else
        render json: ['No matching passphrase found']
      end
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
