class CreateTourFeedbacks < ActiveRecord::Migration
  def change
    create_table :tour_feedbacks do |t|
      t.references :tour, index: true
      t.references :feedback, index: true
      t.timestamps null: false
    end
  end
end
