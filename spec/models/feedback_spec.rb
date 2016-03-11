require 'rails_helper'

RSpec.describe Feedback, type: :model do
  context 'Creating Feedback' do
    before :all do
      @audience = Audience.new(name: 'Test Audience')
      @tour = Tour.create(name: 'name', audience_id: @audience_id,
                          notes: 'Some notes')
      @feedback = Feedback.new
    end
    after :all do
      @audience.destroy
      @tour.destroy
      @feedback.destroy
    end

    describe 'without an associated tour' do
      it 'should be rejected' do
        @feedback = Feedback.create(rating: 5, comment: 'Tour was good')
        expect(@feedback.save).to be false
      end
    end
    describe 'with a rating less than 0' do
      it 'should be rejected' do
        @feedback = Feedback.create(rating: -1, comment: 'Tour was good',
                                    tour_id: @tour.id)
        expect(@feedback.save).to be false
      end
    end
    describe 'with a rating greater than 5' do
      it 'should be rejected' do
        @feedback = Feedback.create(rating: 6, comment: 'Tour was good',
                                    tour_id: @tour.id)
        expect(@feedback.save).to be false
      end
    end
    describe 'with a rating between 0 to 5 inclusive' do
      it 'should be accepted' do
        6.times do |rating|
          @feedback = Feedback.create(rating: rating, comment: 'Tour was good',
                                      tour_id: @tour.id)
          expect(@feedback.save).to be true
        end
      end
    end
    describe 'with a missing comment' do
      it 'should be accepted' do
        @feedback = Feedback.create(rating: 5, comment: '', tour_id: @tour.id)
        expect(@feedback.save).to be true
      end
    end
  end
end
