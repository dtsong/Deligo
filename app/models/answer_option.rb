class AnswerOption < ActiveRecord::Base
  # Relationships
  belongs_to :questions

  # Validations
  validates_presence_of :option, :question_id
  validates_numericality_of :question_id, only_integer: true 

end
