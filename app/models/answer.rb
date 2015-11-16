class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  
  validates :answerer_id, presence: :true
  validates :answer_option_id, presence: :true
  
end
