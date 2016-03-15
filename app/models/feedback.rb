# Version 1.0
# Feedback Model that model a tour attedants feedback and tour rating
class Feedback < ActiveRecord::Base
  belongs_to :tour
  validates :tour, presence: :true
  validates :rating, presence: :true, inclusion: 0..5
end
