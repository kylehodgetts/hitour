class TourQuiz < ActiveRecord::Base
  belongs_to :tour
  belongs_to :quiz

  validates :tour, presence: :true
  validates :quiz, presence: :true
end
