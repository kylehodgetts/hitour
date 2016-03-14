require 'rails_helper'

RSpec.describe QuestionController, type: :controller do
  describe 'POST #create' do
    before(:each) do
      # Create Quiz
      @quiz = Quiz.create(name: 'Test Quiz')
    end
    describe 'with valid attributes' do
      it 'should add question to quiz' do
        post :create, question: {
          quiz_id: @quiz.id,
          description: 'What is an MRI machine?'
        }
        expect(response.body).to eq '["Succesfully created question"]'
        question = Question.find_by(quiz_id: @quiz.id)
        expect(question.description).to eq 'What is an MRI machine?'
        expect(question.rank).to eq 1
      end
      it 'should add question with rank of 2' do
        Question.create(quiz_id: @quiz.id,
                        description: 'Testing',
                        rank: 1)
        post :create, question: {
          quiz_id: @quiz.id,
          description: 'What?'
        }
        expect(response.body).to eq '["Succesfully created question"]'
        question = Question.find_by(description: 'What?')
        expect(question.rank).to eq 2
      end
    end
  end
end
