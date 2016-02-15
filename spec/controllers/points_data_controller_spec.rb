require 'rails_helper'

RSpec.describe PointsDataController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      create_user_session
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end
