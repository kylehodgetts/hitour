require 'rails_helper'

RSpec.describe Audience, type: :model do
  before :each do
    @audience = Audience.new
  end
  after :each do
    Audience.delete(@audience.id)
  end
  context 'Creating an audience' do
    describe 'with a missing audience name' do
      it 'should be rejected' do
        @audience = Audience.create
        expect(@audience.save).to be false
      end
    end
    describe 'with an empty audience name' do
      it 'should be rejected' do
        @audience = Audience.create(name: '')
        expect(@audience.save).to be false
      end
    end
    describe 'with a valid name' do
      it 'should be accepted' do
        @audience = Audience.create(name: 'Test')
        expect(@audience.save).to be true
        expect(@audience.name).to eq 'Test'
      end
    end
  end
  context 'Updating an Audience' do
    before :each do
      @audience = Audience.create(name: 'Test')
      @audience.save
    end
    after :each do
      Audience.delete(@audience.id)
    end
    describe 'with an empty audience name' do
      it 'should be rejected' do
        @audience.name = ''
        expect(@audience.save).to be false
      end
    end
    describe 'with a valid name' do
      it 'should be accepted' do
        @audience.name = 'New Name'
        expect(@audience.save).to be true
        expect(@audience.name).to eq 'New Name'
      end
    end
  end
  context 'Deleting an Audience' do
    before :each do
      @audience = Audience.create(name: 'Test')
      @audience.save
    end
    describe 'deleting' do
      it 'should remove it from the database' do
        expect(@audience).to be_truthy
        @audience.destroy
        audience = Audience.find_by(id: @audience.id)
        expect(audience).to be nil
      end
    end
  end
  context 'Duplicate Audiences' do
    before :each do
      @audience = Audience.create(name: 'Test')
      @audience.save
    end
    after :each do
      @audience.destroy
    end
    describe 'adding duplicate name' do
      it 'should reject' do
        new_audience = Audience.create(name: @audience.name)
        expect(new_audience.save).to be false
      end
    end
  end
end
