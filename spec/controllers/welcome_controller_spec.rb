require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  # How to mock a log in!
  before(:each) do
    @user = User.create(email: 'user@gmail.com')
    allow_message_expectations_on_nil
    allow(request.env['warden']).to receive(:authenticate!) { @user }
    allow(controller).to receive(:current_user) { @user }
  end

  # Destroy user afterwards
  after do
    @user.destroy
  end

  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end
