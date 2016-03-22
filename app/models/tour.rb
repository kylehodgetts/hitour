# Version 1.0
# Tour model that models a Tour with a collection of ordered Points
# A tour is available to one audience
class Tour < ActiveRecord::Base
	validates :name, presence: :true, uniqueness: true
	belongs_to :audience
	has_many :points, through: :tour_points
	has_many :tour_points
	has_many :tour_sessions
	has_many :feedbacks
	has_one :quiz, through: :tour_quizzes
	auto_strip_attributes :name, squish: true
end
