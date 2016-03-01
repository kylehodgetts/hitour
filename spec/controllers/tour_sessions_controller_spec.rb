require 'rails_helper'

RSpec.describe TourSessionsController, type: :controller do
  describe 'POST #create' do
      before(:each) do
        # MUST create a user session to access controller
        create_user_session
      end
      it 'should create a tour session ' do
        # Create a tour
        alevel = Audience.create(name: 'A-Level Student')
        tour = Tour.create(name: 'Imaging Tour: A-Level',
                           audience_id: alevel.id)
        TourSession.delete_all
        # Create a tour session
        post :create, tour_session: {
          tour_id: tour.id,
          start_date: '01-03-2016',
          duration: '1'
        }
        expect(TourSession.all.size.to_i).to eq 1
        expect(TourSession.all.first.passphrase).not_to eq nil
      end
  end
end
