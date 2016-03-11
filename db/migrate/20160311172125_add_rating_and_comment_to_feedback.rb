class AddRatingAndCommentToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :rating, :integer
    add_column :feedbacks, :comment, :text
  end
end
