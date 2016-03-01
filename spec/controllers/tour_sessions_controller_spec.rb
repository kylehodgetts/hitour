require 'rails_helper'

RSpec.describe TourSessionsController, type: :controller do
  describe 'POST #create' do
      before(:each) do
        # MUST create a user session to access controller
        create_user_session
      end
      it 'should create a tour session ' do
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
        # Check tour session was created
        expect(TourSession.all.size.to_i).to eq 1
        # Check that a passphrase was generated
        expect(TourSession.all.first.passphrase).not_to eq nil
      end
  end
  describe 'PATCH #update' do
      before(:each) do
        # MUST create a user session to access controller
        create_user_session
      end
      it 'should create update tour session ' do
        alevel = Audience.create(name: 'A-Level Student')
        tour = Tour.create(name: 'Imaging Tour: A-Level',
                           audience_id: alevel.id)
        tour_session = TourSession.create(tour_id: tour.id,
                                          start_date: '01-01-2016',
                                          duration: 10,
                                          passphrase: 'hello')
        patch :update, id: tour_session.id, tour_session: {
          passphrase: 'rails123'
        }
        tour_session = TourSession.find(tour_session.id)
        expect(tour_session.passphrase).to eq 'rails123'
      end
  end
end
