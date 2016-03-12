class Answer < ActiveRecord::Base
  belongs_to :question
  # Sets default value
  def init
      self.is_correct = true if is_correct.nil?
  end
end