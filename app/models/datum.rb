class Datum < ActiveRecord::Base
	has_many :points, through: :point_data
	has_many :audiences, through: :data_audiences
	has_many :data_audiences
	has_many :point_data
end
