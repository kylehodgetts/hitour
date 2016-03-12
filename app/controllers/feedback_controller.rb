class FeedbackController < ApplicationController
  def create
    feedback = Feedback.new(feedback_params)
    if feedback.save
      render json: ['Succesfully saved feedback']
    else
      render json: [feedback.errors.full_messages.first]
    end
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
