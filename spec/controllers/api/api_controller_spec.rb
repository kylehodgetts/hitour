require 'rails_helper'

RSpec.describe Api::ApiController, type: :controller do
  before :each do
    @audience = Audience.create(name: 'A-Level Student')
    @tour = Tour.create(name: 'Imaging Tour: A-Level',
                        audience_id: @audience.id)
    @ts = TourSession.create(name: 'TourSession', tour_id: @tour.id,
                             passphrase: 'passphrase',
                             start_date: Date.current, duration: '1')
  end
  describe 'with a valid passphrase' do
    it 'returns the tour associated with that passphrase' do
      get :single_tour, access_key: 'A7DE6825FD96CCC79E63C89B55F88',
                        passphrase: @ts.passphrase
      parsed_response = JSON.parse(response.body)['tours']
      expect(parsed_response).to be_truthy
    end
  end

  # Test that error is returned with invalid passphrase
  # Test that when a valid passphrase has expired, error is returned
end
