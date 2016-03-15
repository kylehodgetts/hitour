require 'rails_helper'

RSpec.describe AnswerController, type: :controller do
  before(:each) do
    Answer.delete_all
    create_user_session
  end
  describe 'POST #create' do
    it 'should add answer and set to true since only 1 answer' do
      question = create_question
      post :create, answer: {
        question_id: question.id,
        value: 'It is a machine'
      }
      answer = Answer.where(question_id: question.id)
      expect(answer.exists?).to be_truthy
      expect(answer.first.is_correct).to be_truthy
    end
    it 'should update other answers to be incorrect' do
      question = create_question
      answer1 = Answer.create(question_id: question.id,
                              value: 'Answer 1',
                              is_correct: true)
      post :create, answer: {
        question_id: question.id,
        value: 'It is a machine',
        is_correct: true
      }
      expect(response.body).to eq '["Succesfully added answer"]'
      answer1 = Answer.find(answer1.id)
      expect(answer1.is_correct).not_to be_truthy
      answer = Answer.find_by(question_id: question.id,
                              value: 'It is a machine')
      expect(answer.is_correct).to be_truthy
    end
  end
end
