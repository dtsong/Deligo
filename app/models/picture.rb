class Picture < ActiveRecord::Base
  # Relationship
  belongs_to :question
  
  before_validation :set_question
  after_create :set_actual_question

  # Validations
  validates_presence_of :picture_url, :question_id 
  validates_numericality_of :question_id, only_integer: true 
  #validates_format_of :picture_url, with: /_^(?:(?:https?|ftp)://)(?:\S+(?::\S*)?@)?(?:(?!10(?:\.\d{1,3}){3})(?!127(?:\.\d{1,3}){3})(?!169\.254(?:\.\d{1,3}){2})(?!192\.168(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\x{00a1}-\x{ffff}0-9]+-?)*[a-z\x{00a1}-\x{ffff}0-9]+)(?:\.(?:[a-z\x{00a1}-\x{ffff}0-9]+-?)*[a-z\x{00a1}-\x{ffff}0-9]+)*(?:\.(?:[a-z\x{00a1}-\x{ffff}]{2,})))(?::\d{2,5})?(?:/[^\s]*)?$_iuS/, message: "is not a valid format"

  # Scopes
  scope :for_question, -> (question_id) { where("curriculum_id = ?", curriculum_id) }

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
