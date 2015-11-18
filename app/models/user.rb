class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  
  #has_secure_password

  # Relationships
  has_many :questions
  has_many :friendships
  has_many :answers

  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }  
  validates_presence_of :password, on: :create
  validates_presence_of :password_confirmation, on: :create
  validates_presence_of :name
  validates_confirmation_of :password, on: :create, message: "does not match"
  validates_length_of :password, minimum: 4, message: "must be at least 4 characters long", allow_blank: true

  # Scopes
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :alphabetical, -> { where(:name) }

  def proper_name
    name 
  end 

  private 
  def self.authenticate(username, password)
  	find_by_username(username).try(:authenticate, password)
  end

end
