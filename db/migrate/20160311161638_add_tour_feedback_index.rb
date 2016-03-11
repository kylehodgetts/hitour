class AddTourFeedbackIndex < ActiveRecord::Migration
  def change
    add_reference :feedbacks, :tour, index: true
  end
end
