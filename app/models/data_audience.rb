# Version 1.0
# Data Audience model modelling the relationship
# between a Datum and Audience records
class DataAudience < ActiveRecord::Base
	belongs_to :data
	belongs_to :audience
end
