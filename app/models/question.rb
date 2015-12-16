class Question < ActiveRecord::Base
  # Relationships
  belongs_to :user
  has_many :answer_options
  has_many :pictures
  has_many :answers, through: :answer_options
  mount_uploader :picture, PictureUploader

  accepts_nested_attributes_for :answer_options, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :pictures, reject_if: :all_blank, allow_destroy: true

  #before_validation :set_asker
  before_save :set_open
  before_save :set_friends
  before_save :set_public

  # Validations
  validates_presence_of :question_text, :creator_id

  # Scopes
  scope :for_creator, -> (creator_id) { where("creator_id = ?", creator_id) }
  scope :open, -> { where(open: true) }
  scope :closed, -> { where(open: false) }
  scope :not_creator, -> (creator_id) { where("creator_id != ?", creator_id) }

  def self.get_answered_question_id(user_id)
    # ID of the answer options that were answered by the user
    all_answered_answer_option_ids = Answer.where(["answerer_id = ?", user_id]).select(:answer_option_id).map(&:answer_option_id).uniq
    # ID of all the questions that were answered by the user
    all_answered_question_id = AnswerOption.where(['id IN (?)',all_answered_answer_option_ids]).select(:question_id).map(&:question_id).uniq
    return all_answered_question_id
  end

  def self.first_unanswered(user_id)
    all_answered_question_id = Question.not_creator(user_id).get_answered_question_id(user_id)
    Question.where(['id NOT IN (?)', all_answered_question_id]).first
  end

  def previous(user_id)
    all_answered_question_id = Question.not_creator(user_id).get_answered_question_id(user_id)

    Question.where(['id NOT IN (?)', all_answered_question_id]).where(['id < ?', id]).last
    # Question.where(["id < ?", id]).last
  end

  def next(user_id)
    all_answered_question_id = Question.not_creator(user_id).get_answered_question_id(user_id)

    Question.where(['id NOT IN (?)', all_answered_question_id]).where(['id > ?', id]).first

  end

  #def change_open
    #if self.open == true
      #self.open = false
      #end
  #end


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
  
  def set_friends
    if self.ask_friends == nil
      self.ask_friends = false
    end
  end
  
  def set_public
    if self.ask_public == nil
      self.ask_public = false
    end
  end

end
