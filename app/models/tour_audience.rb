class TourAudience < ActiveRecord::Base
	belongs_to :tour
	belongs_to :audience
end
