class QuizController < ApplicationController
  def index
    @quiz = Quiz.includes(:questions).map do |quiz|
      quiz.as_json.merge(
        questions: quiz.questions.as_json
      )
    end
    api_response(@quiz)
  end

  def show
    @quiz = Quiz.includes(:questions).find(params[:id])
    api_response(@quiz)
  end

  def create
    quiz = Quiz.new(quiz_params)
    if quiz.save
      render json: ['Succesfully created quiz']
    else
      render json: [quiz.errors.full_messages.first]
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
