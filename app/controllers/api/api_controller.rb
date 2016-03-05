module Api
  class ApiController < ApplicationController
    before_action :api_authenticate!

    def single_tour
      tour_session = TourSession.find_by passphrase: params[:passphrase]
      if tour_session
        response = {}
        response[:tour_session] = tour_session
        response[:tours] = Tour.find(tour_session[:tour_id]).as_json
        populate_tour_reponse(response[:tours])
        render json: response
      else
        render json: 'Passprase Invalid'
      end
    end

    private

    # Insert array of points into data response
    def populate_tour_reponse(tour)
      tour[:points] = TourPoint.where(tour_id: tour['id']).as_json
      tour[:points].each do |point|
        point[:name] = Point.find(point['point_id']).name
        pd = PointDatum.where(point_id: point['id'])
        point[:data] = []
        pd.each do |point_datum|
          populate_data_reponse(tour, point, point_datum)
        end
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
        datum[:rank] = point_datum['rank']
        datum[:audiences] = audiences
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
        if audience[:id] == tour['audience_id']
          point[:data] << datum
          break
        end
      end
    end
  end
end
