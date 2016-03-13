class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :rank
      t.text :description
      t.integer :correctly_answered
      t.integer :wrongly_answered
      t.timestamps null: false
    end
  end
end
