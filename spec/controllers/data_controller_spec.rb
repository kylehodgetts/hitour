require 'rails_helper'

RSpec.describe DataController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      create_user_session
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      create_user_session
      datum = Datum.create(title: 'Test Data',
                           description: 'Test Description',
                           url: 'https://s3-us-west-2.amazonaws.com/hitourbucket/Notes.txt')
      get :show, id: datum.id
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    before(:each) do
      create_user_session
      Datum.delete_all
    end
    it 'should upload image to amazon s3 and return a url' do
      post :create,
           file: fixture_file_upload('/files/test_image.jpg', 'image/jpg'),
           title: 'Test Data Upload',
           description: 'This is a test data upload'
      expect(response).to redirect_to data_path
      expect(Datum.all.size).to eq 1
      datum = Datum.find_by(title: 'Test Data Upload')
      expect(datum.url.include?('http')).to eq true
    end
  end
end
