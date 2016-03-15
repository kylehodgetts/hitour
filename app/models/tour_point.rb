# Version 1.0
# Tour Point model that models the relationship between
# a Tour and a Point
# Rank denotes where Point will appear in the Tour
class TourPoint < ActiveRecord::Base
	belongs_to :tour
	belongs_to :point

	validates :tour, presence: :true
	validates :point, presence: :true
	validates :rank, presence: :true, numericality: { greater_than: 0 }
end
