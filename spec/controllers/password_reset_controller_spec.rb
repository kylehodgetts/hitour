require 'rails_helper'

RSpec.describe PasswordResetController, type: :controller do
  describe 'POST Activation (recovery system)' do
    context 'temporary password' do
      before(:each) do
        User.delete(User.find_by(email: 'phileas.hocquard@gmail.com'))
        @user = User.create(email: 'phileas.hocquard@gmail.com',
                            password: 'forgottenpassword',
                            temporarypassword: 'qweqwejhiq9qwqw83124')
        @user.save
      end
      it 'should establish a session and redirect to manage user profile' do
        post :activate, temporarypassword: 'qweqwejhiq9qwqw83124'
        expect(session[:user_id]).to eq(@user.id)
        expect(response).to redirect_to user_path(@user.id)
      end
    end
    context 'with an invalid recoveryHash' do
      it 'should not establish a session and redirect to the log in page' do
        get :activate, temporarypassword: 'wrongHash'
        expect(response).to redirect_to root_path
      end
    end
  end
end
