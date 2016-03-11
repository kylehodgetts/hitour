class Feedback < ActiveRecord::Base
  has_many: :tours, through: :tour_feedbacks
  has_many: :tours
end
