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
end
