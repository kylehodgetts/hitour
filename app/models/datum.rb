class Datum < ActiveRecord::Base
	has_many :points, :through => :point_data
	has_many :audience, through: :data_audience
	has_many :point_data
end
