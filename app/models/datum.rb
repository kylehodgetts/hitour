class Datum < ActiveRecord::Base
	has_many :points, through: :point_data
end
