# Version 1.0
# Feedback Controller responsible for creating and deleting
# feedback records
class FeedbackController < ApplicationController
  # Create a feedback record with the given parameters
  # Render a successful response if save is successful
  # Else respond with the ActiveRecord error message
  def create
    feedback = Feedback.new(feedback_params)
    if feedback.save
      render json: ['Succesfully saved feedback']
    else
      render json: [feedback.errors.full_messages.first]
    end
  end

  def data
    feedbacks = Feedback.where(tour_id: params[:tour_id]).group(:rating).count
    api_response(feedbacks)
  end

  # Destroy the Feedback record whose id matches
  # the given id
  def destroy
    feedback = Feedback.find(params[:id])
    feedback.delete
    render json: ['Deleted Feedback']
  end

  private

  # Require a record of type Feedback and permit the given attributes
  def feedback_params
    params.require(:feedback).permit(:tour_id, :comment, :rating)
  end
end
