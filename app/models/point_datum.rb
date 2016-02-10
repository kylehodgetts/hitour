class PointDatum < ActiveRecord::Base
	belongs_to :point
	belongs_to :data
end
