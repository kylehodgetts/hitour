class Tour < ActiveRecord::Base
	validates :name, uniqueness: true
	has_one :audience
end
