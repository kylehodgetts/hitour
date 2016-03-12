class QuestionController < ApplicationController
  def show
    question = Question.includes(:answers).find(params[:id])
    api_response(question)
  end

  def create
    params[:question][:rank] = max_rank(params[:question][:quiz_id])
    question = Question.new(question_params)
    if question.save
      render json: ['Succesfully created question']
    else
      render json: [question.errors.full_messages.first]
    end
  end

  # Finds Max Rank of all questions
  # For A particular Quiz
  def max_rank(quiz_id)
    rank = Question.where(quiz_id: quiz_id).maximum(:rank)
    rank = -1 if rank.nil?
    rank + 1
  end

  def update
    question = Question.find(params[:id])
    if question.update_attributes(question_params)
      render json: ['Updated question!']
    else
      render json: [question.errors.full_messages.first]
    end
  end

  def destroy
    Question.find(params[:id]).delete
    render json: ['Deleted question']
  end

  private

  def question_params
    params.require(:question).permit(:quiz_id, :description, :rank)
  end
end
