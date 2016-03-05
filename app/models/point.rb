class Point < ActiveRecord::Base
	has_many :data, through: :point_data
	validates :name, presence: :true, length: { minimum: 5 },
									 uniqueness: { case_sensitive: false }
	has_many :point_data

	auto_strip_attributes :name, squish: true
end
