class RemoveTourFeedback < ActiveRecord::Migration
  def change
    drop_table :tour_feedbacks
  end
end
