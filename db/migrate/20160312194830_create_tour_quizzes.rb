class CreateTourQuizzes < ActiveRecord::Migration
  def change
    create_table :tour_quizzes do |t|
      t.references :tour, index: true
      t.references :quiz, index: true
      t.timestamps null: false
    end
  end
end
