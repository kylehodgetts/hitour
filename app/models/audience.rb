# Version 1.0
# Audience model that has many tours available to it
class Audience < ActiveRecord::Base
	validates :name, presence: :true, uniqueness: true
	has_many :tours
	has_many :data, through: :data_audiences
	has_many :data_audiences

	auto_strip_attributes :name, squish: true
end
