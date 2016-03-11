class Feedback < ActiveRecord::Base
  belongs_to :tour
  validates :tour, presence: :true
  validates :rating, presence: :true, inclusion: 0..5
end
