require 'rails_helper'

RSpec.describe TourQuiz, type: :model do
  context 'Creating a TourQuiz pair' do
    before :all do
      @tour = create_tour
      @quiz = Quiz.create(name: 'A Quiz')
      @tour_quiz = TourQuiz.new
    end
    after :all do
      @tour.destroy
      @quiz.destroy
      @tour_quiz.destroy
    end
    describe 'with a missing quiz' do
      it 'should be rejected' do
        @tour_quiz = TourQuiz.create(tour_id: @tour.id)
        expect(@tour_quiz.save).to be false
      end
    end
    describe 'with an invalid quiz' do
      it 'should be rejected' do
        false_quiz_id = Quiz.last.id + 1
        @tour_quiz = TourQuiz.create(tour_id: @tour.id, quiz_id: false_quiz_id)
        expect(@tour_quiz.save).to be false
      end
    end
    describe 'with a missing tour' do
      it 'should be rejected' do
        @tour_quiz = TourQuiz.create(quiz_id: @quiz.id)
        expect(@tour_quiz.save).to be false
      end
    end
    describe 'with an invalid tour' do
      it 'should be rejected' do
        false_tour_id = Tour.last.id + 1
        @tour_quiz = TourQuiz.create(tour_id: false_tour_id, quiz_id: @quiz.id)
        expect(@tour_quiz.save).to be false
      end
    end
    describe 'with valid tour and valid quiz' do
      it 'should be accepted' do
        @tour_quiz = TourQuiz.create(tour_id: @tour.id, quiz_id: @quiz.id)
        expect(@tour_quiz.save).to be true
      end
    end
  end
end
