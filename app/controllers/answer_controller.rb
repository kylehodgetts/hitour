class AnswerController < ApplicationController
  def create
    answer = Answer.params(answer_params)
    if answer.save
      render json: ['Succesfully added answer']
    else
      render json: [answer.errors.full_messages.first]
    end
  end

  def update
    answer = Answer.find(params[:id])
    if answer.update_attributes(answer_params)
      render json: ['Updated answer!']
    else
      render json: [answer.errors.full_messages.first]
    end
  end

  def destroy
    Answer.find(params[:id]).delete
    render json: ['Deleted Answer']
  end

  private

  def answer_params
    params.require(:answer).permit(:question_id, :value, is_correct)
  end
end
