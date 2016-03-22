# Version 1.0
# Quiz model.
# Quizzes have collection of questions
class Quiz < ActiveRecord::Base
  has_many :tour_quizzes
  has_many :tours, through: :tour_quizzes, dependent: :destroy
  has_many :questions
  validates :name, presence: :true,
                   uniqueness: { case_sensitive: false }
end
