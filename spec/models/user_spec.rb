require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new
  end
  after(:each) do
    User.delete(@user.id)
  end
  describe 'when adding a user with a valid email' do
    it 'should succeed' do
      @user = User.create(email: 'bob@google.com', password: 'password')
      expect(@user.save).to eq(true)
    end
  end
  describe 'when attempting to add a user with an invalid email' do
    it 'should fail if the email is blank' do
      @user = User.create(email: '', password: 'password')
      expect(@user.save).to eq(false)
    end
    it 'should fail if invalid format' do
      @user = User.create(email: 'kyle@email.', password: 'password')
      expect(@user.save).to eq(false)
    end
    it 'should fail if already authorised' do
      @user = User.create(email: 'bob@mail.com', password: 'password')
      @user.save
      second_u = User.create(email: 'bob@mail.com', password: 'password')
      expect(second_u.save).to eq(false)
    end
  end
  describe 'when attempting to add a user with an invalid password' do
    it 'should fail if password is blank' do
      @user = User.create(email: 'kyle@mail.com', password: '')
      expect(@user.save).to eq(false)
    end
    it 'should fail when the password is less than 6 characters' do
      @user = User.create(email: 'kyle@mail.com', password: 'pass')
      expect(@user.save).to eq(false)
    end
  end
end
