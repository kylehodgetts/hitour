class TourQuiz < ActiveRecord::Base
  belongs_to :tour
  belongs_to :quiz
end
