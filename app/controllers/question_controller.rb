class QuestionController < ApplicationController
  def create
  end

  def destroy
  end

  private

  def question_params
    params.require(:question).permit(:quiz_id, :description, :rank)
  end
end
