# Version 1.0
# Controller reponsible for creating and mutating answer
# records
class AnswerController < ApplicationController
  before_action :authenticate_user!
  # Create an Answer record using the answer params passed
  # from the request
  def create
    is_correct = params[:answer][:is_correct]
    params[:answer][:is_correct] = true if is_correct.eql? 'true'
    answer = Answer.new(answer_params)
    question_id = params[:answer][:question_id]
    if answer.save
      update_answers(question_id, answer.id)
      render json: ['Succesfully added answer']
    else
      render json: [answer.errors.full_messages.first]
    end
  end

  # Update the answer whose id matches that
  # given in the parameter
  def update
    answer = Answer.find(params[:id])
    if answer.update_attributes(answer_params)
      render json: ['Updated answer!']
    else
      render json: [answer.errors.full_messages.first]
    end
  end

  # Destroy the Answer record whose id
  # matches that in the parameter
  def destroy
    old_answer = Answer.find(params[:id]).delete
    # Update other answers if old answer correct
    if old_answer.is_correct
      answers = Answer.where(question_id: old_answer.question_id)
      answers.first.is_correct = true if answers.exists?
      answers.first.save if answers.exists?
    end
    render json: ['Deleted Answer']
  end

  # Make the given answer, whose id matches
  # that given in the parameters, the correct answer
  # for its associated question
  def make_correct
    answer = Answer.find(params[:id])
    question_id = answer.question_id
    answer.is_correct = true
    answer.save
    update_answers(question_id, answer.id)
    render json: ['Succesfully set answer to correct']
  end

  private

  # Require a parameter of type answer and permit
  # the given attributes
  def answer_params
    params.require(:answer).permit(:question_id, :value, :is_correct)
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
    answer.is_correct = true if Answer.where(question_id: question_id).size == 1
    answer.save
  end
end
