class PointDatum < ActiveRecord::Base
	belongs_to :point
	belongs_to :datum

	validates :point, presence: :true
	validates :datum, presence: :true
	validates :rank, presence: :true, numericality: { greater_than: 0 }
end
