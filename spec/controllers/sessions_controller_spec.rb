require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET new' do
    context 'a logged in user' do
      before(:each) do
        User.delete(User.find_by(email: 'kyle@gmail.com'))
        @user = User.create(email: 'kyle@gmail.com', password: 'password', activated: true)
        @user.save
        get :create, email: @user.email, password: 'password'
      end
      it 'should redirect to the root' do
        get :new
        expect(response).to redirect_to '/'
      end
    end
    context 'not logged in' do
      it 'should redirect to the login' do
        get :new
        expect(response).to have_http_status '200'
      end
    end
  end
  describe 'GET login' do
    context 'with a valid user' do
      before(:each) do
        User.delete(User.find_by(email: 'kyle@gmail.com'))
        @user = User.create(email: 'kyle@gmail.com', password: 'password', activated: true)
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
    describe 'GET login' do
    context 'with a valid new user' do
      before(:each) do
        User.delete(User.find_by(email: 'kyle@gmail.com'))
        @user = User.create(email: 'kyle@gmail.com', password: 'password',activated: false)
        @user.save
      end
      it 'should establish a session and redirect to manage user profile' do
        get :create, email: 'kyle@gmail.com', password: 'password'
        expect(session[:user_id]).to eq(@user.id)
         # expect(@user).to receive(:update_attribute).with(:activated,true).and_return(true)
        expect(response).to redirect_to update_profile_path(@user.id)
       end
    end
    context 'with an invalid user' do
      it 'should not establish a session and redirect to the log in page' do
        get :create, email: 'invalid@mail.com', password: 'password'
        expect(response).to redirect_to '/login'
      end
    end
  end
end
