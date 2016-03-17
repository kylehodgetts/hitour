# Version 1.0
# Question Controller responsible for creating and manipulating
# question records that appear in Quizzes
class QuestionController < ApplicationController
  before_action :authenticate_user!

  # Create a Question record, saving it to the database
  # Return a success message, if record is saved
  # Otherwise, return an error message
  def create
    params[:question][:rank] = max_rank(params[:question][:quiz_id])
    question = Question.new(question_params)
    if question.save
      render json: ['Succesfully created question']
    else
      render json: [question.errors.full_messages.first]
    end
  end

  # Update a given question whose id matches that
  # given in the params
  # Return a success message, if record is updated
  # Otherwise, return an error message
  def update
    question = Question.find(params[:id])
    if question.update_attributes(question_params)
      render json: ['Updated question!']
    else
      render json: [question.errors.full_messages.first]
    end
  end

  # Destroy the question whose id matches that
  # given in the params
  def destroy
    Question.find(params[:id]).delete
    render json: ['Deleted question']
  end

  private

  # Require a record of type Question and permit the given attributes
  def question_params
    params.require(:question).permit(:quiz_id, :description, :rank)
  end

  # Finds Max Rank of all questions
  # For A particular Quiz
  def max_rank(quiz_id)
    rank = Question.where(quiz_id: quiz_id).maximum(:rank)
    rank = 0 if rank.nil?
    rank + 1
  end
end
