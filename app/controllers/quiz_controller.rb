class QuizController < ApplicationController
  before_action :authenticate_user!
  def index
    @quiz = Quiz.includes(:questions).map do |quiz|
      quiz.as_json.merge(
        data: quiz.name,
        delete_url: delete_quiz_path(quiz),
        show_url: quiz_path(quiz)
      )
    end
    api_response(@quiz)
  end

  def show
    @quiz = Quiz.includes(:questions).find(params[:id])
    questions = quiz_questions
    @quiz = @quiz.as_json
    @quiz['questions'] = questions
    api_response(@quiz)
  end

  def create
    quiz = Quiz.new(quiz_params)
    quiz.save
    if quiz.errors.full_messages.empty?
      render json: ['Succesfully created quiz']
    else
      render json: [quiz.errors.full_messages.first]
    end
  rescue ActiveRecord::RecordNotUnique
	  render json: ['That name has already been used.']
  end

  def add_tour_quiz
    tour = Tour.find(params[:tour][:id])
    quiz = Quiz.find(params[:quiz][:id])
    tour_quiz = TourQuiz.create(tour_id: tour.id, quiz_id: quiz.id)
    if tour_quiz.errors.full_messages.first.nil?
      render json: ['Added quiz']
    else
      render json: [tour_quiz.errors.full_messages.first]
    end
  end

  def remove_tour_quiz
    tour_quiz = TourQuiz.find(params[:id])
    if tour_quiz
      render json: ['Removed Quiz']
    else
      render json: [tour_quiz.errors.full_messages.first]
    end
  end

  def update
    quiz = Quiz.find(params[:id])
    if quiz.update_attributes(quiz_params)
      render json: ['Successfully updated Quiz'], status: 200
    else
      render json: [quiz.errors.full_messages.first]
    end
  end

  def destroy
    Quiz.find(params[:id]).destroy
    render json: ['Deleted quiz']
  end

  private

  def quiz_params
    params.require(:quiz).permit(:name)
  end
end
