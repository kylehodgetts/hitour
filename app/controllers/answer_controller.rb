class AnswerController < ApplicationController
  def create
    answer = Answer.new(answer_params)
    question_id = params[:answer][:question_id]
    if answer.save
      update_answers(question_id, answer.id)
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

  # This will make sure other answers
  # Are marked as incorrect
  def update_answers(question_id, answer_id)
    answer = Answer.find(answer_id)
    if answer.is_correct || answer.is_correct == 1
      answers = Answer.where(question_id: question_id)
      answers.each do |a|
        a.is_correct = false unless a.id == answer_id
        a.save
      end
    end
  end

  def destroy
    Answer.find(params[:id]).delete
    render json: ['Deleted Answer']
  end

  private

  def answer_params
    params.require(:answer).permit(:question_id, :value, :is_correct)
  end
end
