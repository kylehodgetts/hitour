require 'rails_helper'

RSpec.describe FeedbackController, type: :controller do
  describe 'POST #create' do
    before(:each) do
      Feedback.delete_all
    end
    describe 'create feedback' do
      it 'with valid parameters ' do
        # Create a tour session
        tour = create_tour
        post :create, feedback: {
          tour_id: tour.id,
          comment: 'Amazing Tour',
          rating: 4
        }
        # Check response is correct
        expect(response.body).to eq '["Succesfully saved feedback"]'
        feedback = Feedback.where(tour_id: tour.id).exists?
        # Check it was added to database
        expect(feedback).to be_truthy
      end
      it 'with invalid parameters ' do
        # Create a tour session
        tour = create_tour
        post :create, feedback: {
          tour_id: tour.id,
          comment: 'Amazing Tour',
          rating: '-1'
        }
        # Check response is correct
        expect(response.body).to eq '["Rating is not included in the list"]'
        feedback = Feedback.where(tour_id: tour.id).exists?
        # Check it was added to database
        expect(feedback).not_to be_truthy
      end
      it 'should allow missing comment ' do
        # Create a tour session
        tour = create_tour
        post :create, feedback: {
          tour_id: tour.id,
          rating: 4
        }
        # Check response is correct
        expect(response.body).to eq '["Succesfully saved feedback"]'
        feedback = Feedback.where(tour_id: tour.id).exists?
        # Check it was added to database
        expect(feedback).to be_truthy
      end
    end
  end
end
