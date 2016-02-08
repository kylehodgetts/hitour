class Audience < ActiveRecord::Base
	validates :name, uniqueness: true
	has_many :tours
	has_many :data
end
