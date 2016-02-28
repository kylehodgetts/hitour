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

  describe 'POST #create' do
      before(:each) do
        # MUST create a user session to access controller
        create_user_session
        User.delete(User.find_by(email:'someone@gmail.com'))
        post :create, user:
          {
            email: 'someone@gmail.com'
          }
        @user = User.find_by(email: 'someone@gmail.com')
      end
      describe 'add an unactivated user' do
        it 'should have a password of size 60 and the user should be saved' do
          expect(@user.password_digest.length).to eq 60
          expect(response).to have_http_status  '200'
          parsed_body = JSON.parse(response.body)
          expect(parsed_body[0]).to eq('Added user!')
        end
      end
  end

  describe 'GET #show' do
    context 'while signed in' do
      before(:each) do
        User.delete(User.find_by(email: 'kyle@gmail.com'))
        User.delete(User.find_by(email: 'dude@gmail.com'))
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

  describe 'PATCH #update' do
    before(:each) do
      User.delete(User.find_by(email: 'kyle@gmail.com'))
      @user = User.create(email: 'kyle@gmail.com', password: 'password')
      @user.save
      session[:user_id] = @user.id
    end
    describe 'with password not matching confirm password' do
      it 'should not update the user entry' do
        password = 'new_password'
        patch :update, id: @user.id, user:
          {
            email: @user.email,
            password: password,
            cpassword: 'password'
          }
        parsed_body = JSON.parse(response.body)
        expect(parsed_body[0]).to eq('Passwords must be non empty and match')
      end
    end

    describe 'with password matching confirm password' do
      it 'should update the user entry' do
        password = 'new_password'
        patch :update, id: @user.id, user:
          {
            email: @user.email,
            password: password,
            cpassword: password
          }
        # Refetch user for updated attributes
        @user = User.find(@user.id)
        expect(@user.activated).to eq(true)
        parsed_body = JSON.parse(response.body)
        expect(parsed_body[0]).to eq('Successfully updated password')
      end
    end
  end
end
