require 'rails_helper'

RSpec.describe Tour, type: :model do
  before :each do
    @tour = Tour.new
    @audience = Audience.new(name: 'Test Audience')
    @audience.save
  end
  after :each do
    @tour.destroy
    @audience.destroy
  end
  context 'Creating a tour' do
    describe 'with a missing name' do
      it 'should be rejected' do
        @tour = Tour.create(audience_id: @audience.id)
        expect(@tour.save).to be false
      end
    end
    describe 'with an empty name' do
      it 'should be rejected' do
        @tour = Tour.create(name: '', audience_id: @audience.id)
        expect(@tour.save).to be false
      end
    end
    describe 'without an audience' do
      it 'should be rejected' do
        @tour = Tour.create(name: '')
        expect(@tour.save).to be false
      end
    end
  end
  context 'Updating a Tour' do
    before :each do
      @tour = Tour.create(name: 'name', audience_id: @audience_id,
                          notes: 'Some notes')
      @tour.save
    end
    describe 'with an empty name' do
      it 'should be rejected' do
        @tour.name = ''
        expect(@tour.save).to be false
      end
    end
    describe 'with a valid name' do
      it 'should be accepted' do
        @tour.name = 'new name'
        expect(@tour.save).to be true
      end
    end
    describe 'with a new audience' do
      it 'should be accepted' do
        new_audience = Audience.create(name: 'new audience')
        @tour.audience_id = new_audience.id
        expect(@tour.save).to be true
      end
    end
    describe 'with empty notes' do
      it 'should be accepted' do
        @tour.notes = ''
        expect(@tour.save).to be true
      end
    end
    describe 'with new notes' do
      it 'should be accepted' do
        @tour.notes = 'some new notes'
        expect(@tour.save).to be true
      end
    end
  end
end
