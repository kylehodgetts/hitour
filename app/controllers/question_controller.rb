class QuestionController < ApplicationController
  def create
    params[:rank] = max_rank
    question = Question.params(question_params)
    if question.save
      render json: ['Succesfully created question']
    else
      render json: [question.errors.full_messages.first]
    end
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
