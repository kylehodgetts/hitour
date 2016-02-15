require 'rails_helper'

RSpec.describe DataController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      create_user_session
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      create_user_session
      datum = Datum.create(title:'Test Data',description:'Test Description',url:'https://s3-us-west-2.amazonaws.com/hitourbucket/Notes.txt')
      get :show, {id: datum.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      create_user_session
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end
