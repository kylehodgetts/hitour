class Question < ActiveRecord::Base
  belongs_to :quiz
  has_many :answers

  # Sets default value
  def init
      self.correctly_answered ||= 0
      self.wrongly_answered ||= 0
  end
end
