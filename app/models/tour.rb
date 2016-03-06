class Tour < ActiveRecord::Base
	validates :name, presence: :true, uniqueness: true
	belongs_to :audience
	has_many :points, through: :tour_points
	has_many :tour_points
	has_many :tour_sessions

	auto_strip_attributes :name, squish: true
end
