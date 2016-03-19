# Version 1.0
# Tour Session model that models the relationship between a Tour
# and a Tour Session.
class TourSession < ActiveRecord::Base
  PASSPHRASE_REGEX = /\A[A-z0-9]{5,}+\z/i
  belongs_to :tour

  validates :name, presence: :true
  # Ensure passphrase matches the given regex pattern
  validates :passphrase, presence: true,
                         format: { with: PASSPHRASE_REGEX },
                         uniqueness: true
  validates :tour_id, presence: true
  validates :start_date, presence: true
  validates_date :start_date, on_or_after: -> { Date.current }

  validates :duration, presence: true,
                       numericality: { only_integer: true,
                                       greater_than_or_equal_to: 1
                                      }
  auto_strip_attributes :passphrase, squish: true
end
