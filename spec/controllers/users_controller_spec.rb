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

    # describe 'POST #create' do
    #   it 'should create the user entry' do
    #     User.delete(User.find_by(email:'phileas.hocquard@gmail.com'))
    #     post :create, user:
    #       {
    #         email: 'phileas.hocquard@gmail.com'
    #       }
    #       @user = User.find_by(email:'phileas.hocquard@gmail.com')
    ## I should somehow get the actual password of user which is a random key of size 25.
    #   expect(:password.length).to eq 25
    #   expect(flash[:user_save]).to eq 'true'
    #   end
    # end


  
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

  describe 'POST #update' do
    before(:each) do
      User.delete(User.find_by(email: 'kyle@gmail.com'))
      @user = User.create(email: 'kyle@gmail.com', password: 'password')
      @user.save
      session[:user_id] = @user.id
    end
    describe 'with password not matching confirm password' do
      it 'should not update the user entry' do
        password = 'new_password'
        post :update, id: @user.id,
                      user: @user,
                      password: password,
                      cpassword: 'password1'
        expect(flash[:user_save]).to eq 'false'
      end
    end

    describe 'with password matching confirm password' do
      it 'should update the user entry' do
        password = 'new_password'
        post :update, id: @user.id,
                      user: @user,
                      password: password,
                      cpassword: password
        @user.save
        expect(flash[:user_save]).to eq 'true'
      end
    end
  end
end
