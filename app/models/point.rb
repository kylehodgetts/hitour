class Point < ActiveRecord::Base
	has_many :data, :through => :point_data
	validates :name, uniqueness: true
	has_many :point_data
end
