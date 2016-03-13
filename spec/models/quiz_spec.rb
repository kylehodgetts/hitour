require 'rails_helper'

RSpec.describe Quiz, type: :model do
  before :all do
    @quiz = Quiz.new
  end
  after :all do
    @quiz.destroy
  end
  context 'Creating a quiz' do
    describe 'without a name' do
      it 'should be rejected' do
        @quiz = Quiz.create
        expect(@quiz.save).to be false
      end
    end
    describe 'with an empty name value' do
      it 'should be rejected' do
        @quiz = Quiz.create(name: '')
        expect(@quiz.save).to be false
      end
    end
    describe 'with a valid name value' do
      it 'should be accepted' do
        @quiz = Quiz.create(name: 'A Quiz')
        expect(@quiz.save).to be true
      end
    end
  end
  context 'Modifying Questions to a quiz' do
    before :all do
      @question_1 = Question.create(rank: 1, description: 'Test')
      @question_2 = Question.create(rank: 2, description: 'Other Test')
      @quiz = Quiz.create(name: 'A Quiz')
      @quiz.save
    end
    after :all do
      @question_1.destroy
      @question_2.destroy
      @quiz.destroy
    end
    describe 'adding a question to a quiz' do
      it 'will associate the quiz to the question' do
        @quiz.questions << @question_1
        expect(@quiz.questions.first).to eq @question_1
      end
    end
    describe 'removing a question from a quiz' do
      it 'will remove the association between them' do
        @quiz.questions.delete(@question_1)
        expect(@quiz.questions.first).to be nil
      end
    end
  end
end
