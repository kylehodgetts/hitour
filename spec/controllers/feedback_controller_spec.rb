require 'rails_helper'

RSpec.describe FeedbackController, type: :controller do
  describe 'POST #create' do
    before(:each) do
      # create_user_session
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
        # Check it was added to database
        expect(Feedback.all.size).to eq 1
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
        # Check it was added to database
        expect(Feedback.all.size).to eq 0
      end
    end
  end
end
