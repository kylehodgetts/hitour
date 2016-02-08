class DataAudience < ActiveRecord::Base
	belongs_to :data
	belongs_to :audience
end
