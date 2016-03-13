require 'rails_helper'

RSpec.describe Question, type: :model do
  context 'Creating a Question' do
    before :all do
      @question = Question.new
    end
    after :all do
      @question.destroy
    end
    describe 'without a description' do
      it 'should be rejected' do
        @question = Question.create(rank: 1)
        expect(@question.save).to be false
      end
    end
    describe 'with an empty description value' do
      it 'should be rejected' do
        @question = Question.create(description: '', rank: 1)
        expect(@question.save).to be false
      end
    end
    describe 'with a missing rank' do
      it 'should be rejected' do
        @question = Question.create(description: 'desc')
        expect(@question.save).to be false
      end
    end
    describe 'with a rank less than 1' do
      it 'should be rejected' do
        @question = Question.create(description: '', rank: 0)
        expect(@question.save).to be false
      end
    end
    describe 'with valid parameters' do
      before :all do
        @question = Question.create(description: 'desc', rank: 1)
      end
      it 'should be accepted' do
        expect(@question.save).to be true
      end
      describe 'with passing a correctly_answered parameter' do
        it 'should initialise correctly_answered to 0' do
          expect(@question.correctly_answered).to eq 0
        end
      end
      describe 'with passing a wrongly_answered parameter' do
        it 'should initialise wrongly_answered to 0' do
          expect(@question.wrongly_answered).to eq 0
        end
      end
    end
    describe 'when passing in correctly_answered and wrongly_answered params' do
      before :all do
        @question = Question.create(description: 'desc', rank: 1,
                                    correctly_answered: 1,
                                    wrongly_answered: 2)
      end
      it 'should initialise correctly_answered to given value' do
        expect(@question.correctly_answered).to eq 1
      end
      it 'should initialise wrongly_answered to given value' do
        expect(@question.wrongly_answered).to eq 2
      end
    end
  end
  context 'Modyiying a questions answers' do
    before :all do
      @question = Question.create(description: 'desc', rank: 1)
      @correct_answer = Answer.create(value: 'a', is_correct: true)
      @correct_answer.save
    end
    describe 'adding an answer to a question' do
      it 'will associate the answer to the question' do
        @question.answers << @correct_answer
        expect(@question.answers.first).to eq @correct_answer
      end
    end
    describe 'removing an answer from a question' do
      it 'will remove the association between the question and answer' do
        @question.answers.delete(@correct_answer)
        expect(@question.answers.first).to be nil
      end
    end
  end
end
