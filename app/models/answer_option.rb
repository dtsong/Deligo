class AnswerOption < ActiveRecord::Base
  # Relationships
  belongs_to :question
  has_many :answers
  
  before_validation :set_question
  after_create :set_actual_question

  # Validations
  validates_presence_of :option, :question_id
  validates_numericality_of :question_id, only_integer: true 
  
  private
  
  def set_question
    if self.question_id == nil
      self.question_id = 0
    end
  end
  
  def set_actual_question
    if self.question_id = 0
      last_question = Question.order("created_at").last
      self.question_id = last_question
    end
  end

end
