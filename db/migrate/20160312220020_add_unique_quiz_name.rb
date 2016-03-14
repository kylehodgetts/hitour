class AddUniqueQuizName < ActiveRecord::Migration
  def change
    add_index :quizzes, :name, :unique => true
  end
end
