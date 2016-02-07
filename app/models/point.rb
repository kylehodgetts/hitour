class Point < ActiveRecord::Base
	has_many :data, through: :point_data
end
