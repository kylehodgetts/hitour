class Tour < ActiveRecord::Base
	validates :name, uniqueness: true
	belongs_to :audience
end
