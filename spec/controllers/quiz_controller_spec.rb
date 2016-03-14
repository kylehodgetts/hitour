require 'rails_helper'

RSpec.describe QuizController, type: :controller do
  render_views
  def create_tour_session(tour_id)
    TourSession.create(
      tour_id: tour_id,
      name: 'TourName',
      start_date: Date.current,
      passphrase: 'Passphrase',
      duration: 10)
  end
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
end
