require 'rails_helper'

RSpec.describe PublicQuizController, type: :controller do
  render_views
  def create_tour_session(tour_id)
    TourSession.create(
      tour_id: tour_id,
      name: 'TourName',
      start_date: Date.current,
      passphrase: 'Passphrase',
      duration: 10)
  end
  describe 'GET #attempt_quiz' do
    before(:each) do
      Quiz.delete_all
      TourQuiz.delete_all
    end
    describe 'public quiz page' do
      it 'should be able to access quiz page' do
        quiz = Quiz.create(name: 'Test Quiz')
        tour = create_tour
        TourQuiz.create(quiz_id: quiz.id, tour_id: tour.id)
        tour_session = create_tour_session(tour.id)
        get :attempt_quiz, id: tour_session.passphrase
        expect(response).to have_http_status '200'
        expect(response.body).to include quiz.name
      end
      it 'should prevent access to quiz page' do
        get :attempt_quiz, id: 'invalid_passphrase'
        expect(response).to have_http_status '403'
      end
    end
  end
  describe 'POST #submit_question' do
    before(:each) do
      Quiz.delete_all
      Question.delete_all
      Answer.delete_all
      TourQuiz.delete_all
      session.clear
    end
    describe 'with correct answer' do
      it 'should accept answer and update question frequency' do
        # Need to create question and answers
        quiz = Quiz.create(name: 'Testing Quiz')
        question = Question.create(description: 'Test question',
                                   rank: 1,
                                   quiz_id: quiz.id)
        expect(Question.find(question.id).wrongly_answered).to eq 0
        answer = Answer.create(value: 'A1',
                               is_correct: true,
                               question_id: question.id)
        # Check session is blank
        expect(session[question.id]).to eq nil
        post :submit_question, answer: { id: answer.id },
                               question: { id: question.id }
        expect(response.body).to eq '{"correct":true}'
        # Session should no longer be blank
        expect(session[question.id]).not_to eq nil
        expect(Question.find(question.id).correctly_answered).to eq 1
      end
    end
    describe 'with incorrect answer' do
      it 'should reject answer and update question frequency' do
        # Need to create question and answers
        quiz = Quiz.create(name: 'Testing Quiz')
        question = Question.create(description: 'Test question',
                                   rank: 2,
                                   quiz_id: quiz.id)
        Answer.create(value: 'A1', is_correct: true, question_id: question.id)
        answer2 = Answer.create(value: 'A2',
                                is_correct: false,
                                question_id: question.id)
        post :submit_question, answer: { id: answer2.id },
                               question: { id: question.id }
        # Should return false within the json response
        expect(response.body).to include 'false'
        # Database should be incremented for incorrect response
        expect(Question.find(question.id).wrongly_answered).to eq 1
      end
    end
    describe 'resubmission' do
      it 'should not increment questions wrong and correct frequency' do
        # Need to create question and answers
        quiz = Quiz.create(name: 'Testing Quiz')
        question = Question.create(description: 'Test question',
                                   rank: 2,
                                   quiz_id: quiz.id)
        # Should be 0 initially
        expect(Question.find(question.id).correctly_answered).to eq 0

        answer = Answer.create(value: 'A1', is_correct: true,
                               question_id: question.id)
        # Should submit first time
        post :submit_question, answer: { id: answer.id },
                               question: { id: question.id }
        expect(response.body).to eq '{"correct":true}'
        expect(Question.find(question.id).correctly_answered).to eq 1

        # Should not change this time as already had previous submission
        post :submit_question, answer: { id: answer.id },
                               question: { id: question.id }
        expect(Question.find(question.id).correctly_answered).to eq 1
      end
    end
  end
end
