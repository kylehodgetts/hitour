class Question < ActiveRecord::Base
  belongs_to :quiz
  after_initialize :init
  has_many :answers
  after_initialize :init
  has_many :answers, -> { distinct }
  validates :rank, presence: :true,
                   numericality: { greater_than_or_equal_to: 1 }

  validates :description, presence: :true
  # Sets default value
  def init
      self.correctly_answered ||= 0
      self.wrongly_answered ||= 0
      self.rank ||= 1
  end
end
