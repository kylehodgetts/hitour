class TourPoint < ActiveRecord::Base
	belongs_to :tour
	belongs_to :point
end
