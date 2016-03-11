class TourPoint < ActiveRecord::Base
	belongs_to :tour
	belongs_to :point

	validates :tour, presence: :true
	validates :point, presence: :true
	validates :rank, presence: :true, numericality: { greater_than: 0 }
end
