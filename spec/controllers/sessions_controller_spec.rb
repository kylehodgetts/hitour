require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET login' do
    context 'with a valid user' do
      before(:each) do
        User.delete(User.find_by(email: 'kyle@gmail.com'))
        @user = User.create(email: 'kyle@gmail.com', password: 'password')
        @user.save
      end
      it 'should establish a session and redirect to root' do
        get :create, email: 'kyle@gmail.com', password: 'password'
        expect(session[:user_id]).to eq(@user.id)
        expect(response).to redirect_to '/'
      end
    end
    context 'with an invalid user' do
      it 'should not establish a session and redirect to the log in page' do
        get :create, email: 'invalid@mail.com', password: 'password'
        expect(session[:user_id]).to be(nil)
        expect(response).to redirect_to '/login'
      end
    end
  end
  describe 'GET logout' do
    it 'should destroy any established session and redirect to root' do
      get :destroy
      expect(session[:user_id]).to be(nil)
      expect(response).to redirect_to '/'
    end
  end
end
