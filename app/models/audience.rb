class Audience < ActiveRecord::Base
	validates :name, uniqueness: true
	has_many :tours
	has_many :data, through: :data_audiences
	has_many :data_audiences
end
