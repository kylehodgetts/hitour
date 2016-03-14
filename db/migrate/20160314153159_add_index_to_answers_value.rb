class AddIndexToAnswersValue < ActiveRecord::Migration
  def change
    add_index :answers, [ :question_id, :value ], unique: true
  end
end
