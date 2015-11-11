class AnswerOption < ActiveRecord::Base
  belongs_to :question
  has_many :answers
  
  validates :question_id, presence: :true
  validates :option, presence: :true
  
end
