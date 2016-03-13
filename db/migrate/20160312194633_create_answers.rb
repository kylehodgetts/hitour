class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :question, index: true
      t.text :value
      t.boolean :is_correct
      t.timestamps null: false
    end
  end
end
