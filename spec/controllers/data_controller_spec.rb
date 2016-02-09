require 'rails_helper'

RSpec.describe DataController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      datum = Datum.create(title:'Test Data',description:'Test Description',url:'https://s3-us-west-2.amazonaws.com/hitourbucket/Notes.txt')
      get :show, {:id => datum.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end
