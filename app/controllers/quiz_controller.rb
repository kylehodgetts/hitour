class QuizController < ApplicationController
  def create
    quiz = Quiz.new(quizzes_params)
    if quiz.save
      render json: ['Succesfully created quiz']
    else
      render json: [quiz.errors.full_messages.first]
    end
  end

  def destroy
    Quiz.find(params[:id]).destroy
    render json: ['Deleted quiz']
  end

  private

  def quizzes_params
    params.require(:quiz).permit(:name)
  end
end
