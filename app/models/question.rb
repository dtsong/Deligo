class Question < ActiveRecord::Base
  # Relationships
  belongs_to :user
  has_many :answer_options
  has_many :pictures
  has_many :answers

  # Validations 
  validates_presence_of :question_text, :creator_id

  # Scopes
  scope :for_creator, -> (creator_id) { where("creator_id = ?", creator_id) }
  
end
