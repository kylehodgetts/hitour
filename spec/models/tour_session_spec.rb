require 'rails_helper'

RSpec.describe TourSession, type: :model do
  before(:each) do
    @audience = Audience.create(name: 'audience')
    @tour = Tour.create(name: 'Tour',
                        audience_id: @audience.id)
    @ts = TourSession.new
  end
  after(:each) do
    TourSession.delete(@ts.id)
  end
  context 'Valid Tour Session Entries' do
    describe 'with valid fields' do
      it 'should be accepted' do
        @ts = TourSession.create(name: 'TourSession', tour_id: @tour.id,
                                 passphrase: 'passphrase',
                                 start_date: Date.current, duration: '1')
        expect(@ts.save).to be true
      end
    end
  end
  context 'Invalid Tour Session Entries' do
    describe 'without a name' do
      it 'should be rejected' do
        @ts = TourSession.create(tour_id: @tour.id, passphrase: 'passphrase',
                                 start_date: Date.current, duration: '1')
        expect(@ts.save).to be false
      end
    end
    describe 'without an associated tour' do
      it 'should be rejected' do
        @ts = TourSession.create(name: 'Name', passphrase: 'passphrase',
                                 start_date: Date.current, duration: '1')
        expect(@ts.save).to be false
      end
    end
    describe 'without a startdate' do
      it 'should be rejected' do
        @ts = TourSession.create(name: 'Name', passphrase: 'passphrase',
                                 tour_id: @tour.id, duration: '1')
        expect(@ts.save).to be false
      end
    end
    describe 'with a startdate in the past' do
      it 'should be rejected' do
        @ts = TourSession.create(name: 'Name', passphrase: 'passphrase',
                                 tour_id: @tour.id, duration: '1',
                                 start_date: '01-03-2010')
        expect(@ts.save).to be false
      end
    end
    context 'duration' do
      describe 'without a duration' do
        it 'should be rejected' do
          @ts = TourSession.create(name: 'Name', passphrase: 'passphrase',
                                   tour_id: @tour.id, start_date: Date.current)
          expect(@ts.save).to be false
        end
      end
      describe 'with a duration less than 1' do
        it 'should be rejected' do
          @ts = TourSession.create(name: 'Name', passphrase: 'passphrase',
                                   tour_id: @tour.id, start_date: Date.current,
                                   duration: '0')
          expect(@ts.save).to be false
        end
      end
      describe 'with a duration less than 0' do
        it 'should be rejected' do
          @ts = TourSession.create(name: 'Name', passphrase: 'passphrase',
                                   tour_id: @tour.id, start_date: Date.current,
                                   duration: '-1')
          expect(@ts.save).to be false
        end
      end
    end
    context 'passphrase' do
      describe 'without a passphrase' do
        it 'should be rejected' do
          @ts = TourSession.create(name: 'Name',
                                   tour_id: @tour.id, start_date: Date.current,
                                   duration: '1')
          expect(@ts.save).to be false
        end
      end
      describe 'with a passphrase less than 5 characters' do
        it 'should be rejected' do
          @ts = TourSession.create(name: 'Name', passphrase: 'aaaa',
                                   tour_id: @tour.id, start_date: Date.current,
                                   duration: '1')
          expect(@ts.save).to be false
        end
      end
      describe 'with a malformed passphrase' do
        it 'should be rejected' do
          @ts = TourSession.create(name: 'Name', passphrase: 'aas _ nhdsf',
                                   tour_id: @tour.id, start_date: Date.current,
                                   duration: '1')
          expect(@ts.save).to be false
        end
      end
    end
  end
end
