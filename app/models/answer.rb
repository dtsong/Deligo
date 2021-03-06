class Answer < ActiveRecord::Base
  # Relationships
  belongs_to :user
  belongs_to :question
  
  # Validations
  # validates_presence_of :answerer_id, :answer_option_id
  validates_presence_of :answer_option_id 
  validates_length_of :comments, :maximum => 140, :too_long => "Please be more concise."
  # validates_format_of :picture_url, with: /_^(?:(?:https?|ftp)://)(?:\S+(?::\S*)?@)?(?:(?!10(?:\.\d{1,3}){3})(?!127(?:\.\d{1,3}){3})(?!169\.254(?:\.\d{1,3}){2})(?!192\.168(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\x{00a1}-\x{ffff}0-9]+-?)*[a-z\x{00a1}-\x{ffff}0-9]+)(?:\.(?:[a-z\x{00a1}-\x{ffff}0-9]+-?)*[a-z\x{00a1}-\x{ffff}0-9]+)*(?:\.(?:[a-z\x{00a1}-\x{ffff}]{2,})))(?::\d{2,5})?(?:/[^\s]*)?$_iuS/, message: "is not a valid format"
  
  # Scopes
  scope :for_answerer, -> (answerer_id) { where("answerer_id = ?", answerer_id) }



  def self.find_count(answer_option_id)
  	return Answer.where("answer_option_id = ?" , answer_option_id).count
  end

end
