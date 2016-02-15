class Point < ActiveRecord::Base
	has_many :data, :through => :point_data
	validates :name, uniqueness: true
	has_many :point_data

	auto_strip_attributes :name, :squish => true
end
