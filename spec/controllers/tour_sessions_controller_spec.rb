require 'rails_helper'

RSpec.describe TourSessionsController, type: :controller do
  def create_tour
    alevel = Audience.create(name: 'A-Level Student')
    tour = Tour.create(name: 'Imaging Tour: A-Level',
                       audience_id: alevel.id)
    TourSession.delete_all
    tour
  end
  describe 'POST #create' do
      before(:each) do
        # MUST create a user session to access controller
        create_user_session
      end
      describe 'with valid parameters' do
        it 'should create a tour session ' do
          # Create a tour session
          post :create, tour_session: {
            tour_id: create_tour.id,
            name: 'Test Tour Session',
            start_date: Date.current,
            passphrase: 'passphrase',
            duration: '1'
          }
          # Check tour session was created
          tour_session = TourSession.find_by(name: 'Test Tour Session')
          expect(tour_session).to be_truthy
          # Check that a passphrase was generated
          expect(tour_session.passphrase).not_to eq nil
        end
      end
      context 'with invalid' do
        describe 'name' do
          it 'should respond with name should not be blank' do
            # Create a tour session
            post :create, tour_session: {
              tour_id: create_tour.id,
              name: '',
              start_date: Date.current,
              passphrase: 'passphrase',
              duration: '1'
            }
            expect(response.body).to eq ['Name can\'t be blank'].to_json
          end
        end
        describe 'blank duration' do
          it 'should respond with duration should not be blank' do
            # Create a tour session
            post :create, tour_session: {
              tour_id: create_tour.id,
              name: 'TourName',
              start_date: Date.current,
              passphrase: 'Passphrase',
              duration: ''
            }
            expect(response.body).to eq ['Duration can\'t be blank'].to_json
          end
        end
        describe 'duration less than 1' do
          it 'should respond with duration should not be greater than 1' do
            # Create a tour session
            post :create, tour_session: {
              tour_id: create_tour.id,
              name: 'TourName',
              start_date: Date.current,
              passphrase: 'passphrase',
              duration: '0'
            }
            expected = ['Duration must be greater than or equal to 1'].to_json
            expect(response.body).to eq expected
          end
        end
      end
  end
  describe 'PATCH #update' do
      before(:each) do
        # MUST create a user session to access controller
        create_user_session
      end
      describe 'with a valid passphrase' do
        it 'should update tour session ' do
          tour_session = TourSession.create(tour_id: create_tour.id,
                                            name: 'Test Tour Session',
                                            start_date: Date.current,
                                            duration: 10,
                                            passphrase: 'hello')
          patch :update, id: tour_session.id, tour_session: {
            passphrase: 'rails123'
          }
          tour_session = TourSession.find(tour_session.id)
          expect(tour_session.passphrase).to eq 'rails123'
          expected = ['Successfully updated tour session'].to_json
          expect(response.body).to eq expected
        end
      end
      describe 'with an invalid passphrase' do
        it 'should not update tour session' do
          tour_session = TourSession.create(tour_id: create_tour.id,
                                            name: 'Test Tour Session',
                                            start_date: Date.current,
                                            duration: 10,
                                            passphrase: 'hello')
          patch :update, id: tour_session.id, tour_session: {
            passphrase: ''
          }
          expect(response.body).to eq ['Could not update tour session'].to_json
        end
      end
  end
end
