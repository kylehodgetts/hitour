require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #create' do
    before(:each) do
      User.delete(User.find_by(email: 'kyle@gmail.com'))
      @user = User.create(email: 'kyle@gmail.com', password: 'password')
      @user.save
    end
    it 'should save user to database' do
      user = User.find_by(email: @user.email)
      expect(user).to eq(@user)
    end
  end

  describe 'GET #show' do
    context 'while signed in' do
      before(:each) do
        User.delete(User.find_by(email: 'kyle@gmail.com'))
        @user = User.create(email: 'kyle@gmail.com', password: 'password')
        @user.save
        @other_user = User.create(email: 'dude@gmail.com', password: 'password')
        @other_user.save
        session[:user_id] = @user.id
      end

      it 'should open own profile ' do
        get :show, id: @user.id
        expect(response).to have_http_status '200'
      end

      it 'should not be able to access other profiles via url' do
        get :show, id: @other_user.id
        expect(response).to redirect_to root_path
      end
    end
  end
end
