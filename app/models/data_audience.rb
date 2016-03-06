class DataAudience < ActiveRecord::Base
	belongs_to :data
	belongs_to :audience

	validates :data, presence: :true
	validates :audience, presence: :true

	attr_accessor :id
end
