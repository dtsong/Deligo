class AnswerOption < ActiveRecord::Base
  belongs_to :question
  has_many :answers
  
  before_validation :set_question
  
  validates :question_id, presence: :true
  validates :option, presence: :true
  
  private
  
  def set_question
    last_question = Question.order("created_at").last
    self.question_id = last_question.id
  end

end
