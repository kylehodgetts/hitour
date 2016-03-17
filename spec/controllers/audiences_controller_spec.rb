require 'rails_helper'

RSpec.describe AudiencesController, type: :controller do
  describe '#GET index' do
    before :each do
      create_user_session
      get :index
    end
    it 'should respond with http success' do
      expect(response).to have_http_status 200
    end
    it 'should deliver a non empty response' do
      expect(response.body).to_not be nil
    end
  end
  describe '#POST create' do
    before :each do
      create_user_session
    end
    describe 'with valid parameters' do
      before :each do
        post :create, audience: { name: 'Some audience' }
      end
      it 'should respond with http success' do
        expect(response).to have_http_status 200
      end
      it 'should respond with a success message' do
        expect(response.body).to eq ['Successfully created audience'].to_json
      end
    end
    describe 'with invalid parameters' do
      before :each do
        post :create, audience: { name: '' }
      end
      it 'should respond with http success' do
        expect(response).to have_http_status 200
      end
      it 'should respond with an error message' do
        expect(response.body).to eq ['Couldnt create audience'].to_json
      end
    end
  end
  describe '#DELETE destroy' do
    before :each do
      create_user_session
    end
    describe 'an audience with no tours referencing it' do
      before :each do
        post :create, audience: { name: 'Audience' }
        audience = Audience.find_by(name: 'Audience')
        expect(audience).to be_truthy
        delete :destroy, id: audience.id
      end
      it 'should respond with http success' do
        expect(response).to have_http_status 200
      end
      it 'should respond with a success message' do
        expect(response.body).to eq ['Successfully deleted audience'].to_json
      end
    end
    describe 'an audience with at least one tour referencing it' do
      before :each do
        post :create, audience: { name: 'Audience' }
        audience = Audience.find_by(name: 'Audience')
        tour = Tour.create(name: 'Test Tour',
                           audience_id: audience.id,
                           notes: 'Test Note')
        tour.save
        delete :destroy, id: audience.id
      end
      it 'should respond with http success' do
        expect(response).to have_http_status 200
      end
      it 'should respond with an error message' do
        message = ['Cannot delete Audience while a Tour has it assigned']
        expect(response.body).to eq message.to_json
      end
    end
  end
end
