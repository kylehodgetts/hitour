# Version 1.0
# Quiz Controller responsible for creating and manipulating
# quiz records that will appear in one or more tours
class QuizController < ApplicationController
  before_action :authenticate_user!

  # Prepare all quiz records for response via the
  # hiTour API
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

  # Show a single Quiz whose id matches that
  # given in the params
  # Return the quiz with its collection of questions
  def show
    @quiz = Quiz.includes(:questions).find(params[:id])
    questions = quiz_questions
    @quiz = @quiz.as_json
    @quiz['questions'] = questions
    api_response(@quiz)
  end

  # Create a Quiz record, saving it to the database
  # Return a success message, if record is saved
  # Otherwise, return an error message
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

  # Add the current quiz whose id matches that
  # given in the quiz params to the tour given
  # in the quiz params
  # Return a Successful message if the association is made
  # return an error message otherwise
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

  # Remove the Tour Quiz pair whose id matches that
  # given in the params
  # Return a Successful message if the association is destroyed
  # return an error message otherwise
  def remove_tour_quiz
    tour_quiz = TourQuiz.find(params[:id]).delete
    if tour_quiz
      render json: ['Removed Quiz']
    else
      render json: [tour_quiz.errors.full_messages.first]
    end
  end

  # Update a given quiz whose id matches that
  # given in the params
  # Return a success message, if record is updated
  # Otherwise, return an error message
  def update
    quiz = Quiz.find(params[:id])
    if quiz.update_attributes(quiz_params)
      render json: ['Successfully updated Quiz'], status: 200
    else
      render json: [quiz.errors.full_messages.first]
    end
  end

  # Destroy the quiz whose id matches that
  # given in the params
  def destroy
    Quiz.find(params[:id]).destroy
    render json: ['Deleted quiz']
  end

  private

  # Require a record of type Quiz and permit the given attribute
  def quiz_params
    params.require(:quiz).permit(:name)
  end
end
