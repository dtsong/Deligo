class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answer_options
  has_many :pictures
  has_many :answers, through: :answer_options
  
  accepts_nested_attributes_for :answer_options, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :pictures, reject_if: :all_blank, allow_destroy: true
  
  validates :creator_id, presence: :true
  validates :question_text, presence: :true

end
