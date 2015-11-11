class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answer_options
  has_many :pictures
  has_many :answers, through: :answer_options
  
  validates :creator_id, presence: :true
  validates :question_text, presence: :true
end
