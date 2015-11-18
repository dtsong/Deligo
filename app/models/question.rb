class Question < ActiveRecord::Base
  # Relationships
  belongs_to :user
  has_many :answer_options
  has_many :pictures
  has_many :answers, through: :answer_options
  
  accepts_nested_attributes_for :answer_options, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :pictures, reject_if: :all_blank, allow_destroy: true


  # Validations 
  validates_presence_of :question_text, :creator_id

  # Scopes
  scope :for_creator, -> (creator_id) { where("creator_id = ?", creator_id) }


 

  def previous
    Question.where(["id < ?", id]).last
  end

  def next
    Question.where(["id > ?", id]).first
  end

end
