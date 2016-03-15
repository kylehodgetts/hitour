# Version 1.0
# Answer model that belongs to one question
class Answer < ActiveRecord::Base
  belongs_to :question
  after_initialize :init
  validates :value, presence: :true,
                    # Ensure the uniqueness of the answer value
                    # only within a questions context
                    uniqueness: { scope: :question_id }

  # Sets default values in model
  # for the values that aren't provided
  def init
    self.is_correct = false if is_correct.nil?
  end
end
