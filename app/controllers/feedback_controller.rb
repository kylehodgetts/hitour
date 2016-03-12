class FeedbackController < ApplicationController
  def create
    feedback = Feedback.new(feedback_params)
    render json: ['Succesfully saved feedback'] if feedback.save
  end

  def destroy
    feedback = Feedback.find(params[:id])
    feedback.delete
    render json: ['Deleted Feedback']
  end

  private

  def feedback_params
    params.require(:feedback).permit(:tour_id, :comment, :rating)
  end
end
