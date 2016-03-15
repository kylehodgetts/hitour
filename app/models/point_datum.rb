# Version 1.0
# Point Datum model that models the relationship
# between a Point and Datum.
# Rank corresponds to the order the datum appears in the point
class PointDatum < ActiveRecord::Base
	belongs_to :point
	belongs_to :datum

	validates :point, presence: :true
	validates :datum, presence: :true
	validates :rank, presence: :true, numericality: { greater_than: 0 }
end
