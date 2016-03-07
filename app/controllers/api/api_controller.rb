module Api
  class ApiController < ApplicationController
    before_action :api_authenticate!

    def single_tour
      tour_session = TourSession.find_by passphrase: params[:passphrase]
      if tour_session
        response = {}
        response[:tour_session] = tour_session
        tour = Tour.find(tour_session[:tour_id]).as_json.symbolize_keys
        tour.delete(:notes)
        response[:tours] = tour
        populate_tour_reponse(response[:tours])
        render json: response
      else
        render json: 'Passprase Invalid'
      end
    end

    private

    # Insert array of points into data response
    def populate_tour_reponse(tour)
      points = TourPoint.where(tour_id: tour[:id]).as_json
      tour[:points] = []
      points.each do |point|
        rank = point['rank']
        point = Point.find(point['id']).as_json.symbolize_keys
        point[:rank] = rank
        point[:data] = {}
        pd = PointDatum.where(point_id: point[:id])
        pd.each { |p_d| populate_data_reponse(tour, point, p_d) }
        tour[:points] << point
      end
    end

    # Insert array of points data into point reponse
    # Data is inserted in according to their rank order in database table
    def populate_data_reponse(tour, point, point_datum)
      data = Datum.where(id: point_datum[:datum_id])
      # For each piece of data populate data's audiences
      data.each do |datum|
        audiences = datum.audiences
        datum = datum.as_json
        datum[:rank] = point_datum[:rank]
        datum[:audiences] = audiences.map { |audience| { id: audience.id } }
        populate_data_audiences(tour, point, datum)
      end
    end

    # Insert array of audiences that data will be available to
    # Only if the data is available for the audience of the queried tour
    # This prevent irrelevant pieces of data being added to the response
    def populate_data_audiences(tour, point, datum)
      # For each audience, check if it matches the tour's audience id
      datum[:audiences].each do |audience|
        # If there is a match, add it to the array and break from loop
        if audience[:id] == tour[:audience_id]
          point[:data][datum[:id]] = datum
          break
        end
      end
    end
  end
end
