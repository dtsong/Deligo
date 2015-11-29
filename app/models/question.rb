class Question < ActiveRecord::Base
  # Relationships
  belongs_to :user
  has_many :answer_options
  has_many :pictures
  has_many :answers, through: :answer_options
  
  accepts_nested_attributes_for :answer_options, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :pictures, reject_if: :all_blank, allow_destroy: true

  #before_validation :set_asker
  before_save :set_open

  # Validations 
  validates_presence_of :question_text, :creator_id, :allow_comments

  # Scopes
  scope :for_creator, -> (creator_id) { where("creator_id = ?", creator_id) }
  scope :open, -> { where(open: true) }
  scope :closed, -> { where(open: false) }


 

  def previous
    Question.where(["id < ?", id]).last
  end

  def next
    Question.where(["id > ?", id]).first
  end
  
  private
  def set_asker
    if self.creator_id == nil
      id = @current_user.id
      self.creator_id = id
    end
  end
  
  def set_open
    if self.open == nil
      self.open = true
    end
  end

end
