require 'rails_helper'

RSpec.describe Api::ApiController, type: :controller do
  describe 'GET #audiences' do
    it 'returns http success' do
      get :audiences, access_key: '1234'
      expect(response).to have_http_status(:success)
    end
  end
end
