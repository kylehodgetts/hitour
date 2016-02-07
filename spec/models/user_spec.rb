require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'when adding a user with a valid email' do
    it 'should succeed' do
      user = User.create(email: 'kylehodgetts@gmail.com')
      expect(user.save).to be(true)
    end
  end
  describe 'when attempting to add a user with an invalid email' do
    it 'should fail if the email is blank' do
      user = User.create(email: '')
      expect(user.save).to be(false)
    end
    it 'should fail if invalid format' do
      user = User.create(email: 'kyle@email.')
      expect(user.save).to be(false)
    end
    it 'should fail if already exists' do
      user = User.create(email: 'kylehodgetts@gmail.com')
      user.save
      second_user = User.create(email: 'kylehodgetts@gmail.com')
      expect(second_user.save).to equal(false)
    end
  end
  describe 'self.from_omniauth' do
    it 'returns nil with an unauthorized email' do
      access_token = { info: { email: 'notallowed@gmail.com' } }
      expect(User.from_omniauth(access_token)).to be(nil)
    end
    it 'returns a user object with an authorized email' do
      User.create(email: 'letmein@gmail.com')
      access_token = { info: { email: 'letmein@gmail.com' } }
      expect(User.from_omniauth(access_token)).to be_an(User)
    end
  end
end
