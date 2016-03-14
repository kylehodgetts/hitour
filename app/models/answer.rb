class Answer < ActiveRecord::Base
  belongs_to :question
  after_initialize :init

  # Sets default value
  def init
      self.is_correct = false if is_correct.nil?
  end
end
