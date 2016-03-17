require 'rails_helper'

RSpec.describe DataAudiencesController, type: :controller do
  before :each do
    create_user_session
  end
  describe '#GET create' do
    describe 'with a unique pair' do
      before :each do
        datum = Datum.create(title: 'title', description: 'desc', url: 'url')
        audience = Audience.create(name: 'audience')
        post :create, data_audience: {
          datum_id: datum.id,
          audience_id: audience.id
        }
      end
      it 'should respond with http success' do
        expect(response).to have_http_status 200
      end
      it 'should respond with a successful message' do
        message = ['Succesfully linked audience to media']
        expect(response.body).to eq message.to_json
      end
    end
    describe 'with a non-unique pair' do
      before :each do
        datum = Datum.create(title: 'title', description: 'desc', url: 'url')
        audience = Audience.create(name: 'audience')
        post :create, data_audience: {
          datum_id: datum.id,
          audience_id: audience.id
        }
        post :create, data_audience: {
          datum_id: datum.id,
          audience_id: audience.id
        }
      end
      it 'should respond with http success' do
        expect(response).to have_http_status 200
      end
      it 'should respond with an error message' do
        message = ['This audience has already been added to this datum']
        expect(response.body). to eq message.to_json
      end
    end
  end
  describe '#DELETE destroy' do
    before :each do
      create_user_session
    end
    describe 'with a valid data audience pair' do
      before :each do
        datum = Datum.create(title: 'title', description: 'desc', url: 'url')
        audience = Audience.create(name: 'audience')
        post :create, data_audience: {
          datum_id: datum.id,
          audience_id: audience.id
        }
        da = DataAudience.find_by(datum_id: datum.id)
        delete :destroy, id: da.id
      end
      it 'should respond with http success' do
        expect(response).to have_http_status 200
      end
      it 'should respond with a successful message' do
        message = ['Succesfully deleted link between data and audience']
        expect(response.body).to eq message.to_json
      end
    end
    describe 'with an invalid data audience pair' do
      before :each do
        datum = Datum.create(title: 'title', description: 'desc', url: 'url')
        audience = Audience.create(name: 'audience')
        post :create, data_audience: {
          datum_id: datum.id,
          audience_id: audience.id
        }
        last = DataAudience.last
        delete :destroy, id: last.id + 1
      end
      it 'should respond with http success' do
        expect(response).to have_http_status 200
      end
      it 'should respond with an error message' do
        message = ['Couldnt delete link between data and audience']
        expect(response.body).to eq message.to_json
      end
    end
  end
end
