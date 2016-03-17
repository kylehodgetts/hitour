# Version 1.0
# Tour Quiz model that models the relationship between
# a Tour and a Quiz
class TourQuiz < ActiveRecord::Base
  belongs_to :tour
  belongs_to :quiz

  # Enforces the presence of both a Tour and Quiz
  validates :tour, presence: :true, uniqueness: true
  validates :quiz, presence: :true
end
