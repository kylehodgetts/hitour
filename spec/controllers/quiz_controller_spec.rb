require 'rails_helper'

RSpec.describe QuizController, type: :controller do
  describe 'POST #create' do
    describe 'with valid parameters' do
      it 'should create a quiz' do
        post :create, quiz: {
          name: 'Test Quiz'
        }
        quiz = Quiz.where(name: 'Test Quiz').exists?
        expect(quiz).to be_truthy
      end
    end
    describe 'duplicate quiz name' do
      it 'should not create a quiz' do
        Quiz.delete_all
        Quiz.create(name: 'Test Quiz')
        post :create, quiz: {
          name: 'Test Quiz'
        }
        expect(response.body).to eq '["Name has already been taken"]'
      end
    end
  end
end
