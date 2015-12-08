class User < ActiveRecord::Base
  attr_accessor :remember_token
  before_save { self.email = email.downcase }

  has_secure_password

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
  validates_presence_of :name
  validates_length_of :password, minimum: 4, message: "must be at least 4 characters long", allow_blank: true

  # Scopes
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :alphabetical, -> { where(:name) }

  filterrific(
  available_filters: [
    :search_query,
  ]
  )

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 3
    where(
      terms.map {
        or_clauses = [
          "LOWER(users.name) LIKE ?",
          "LOWER(users.email) LIKE ?",
          "LOWER(users.phone_number) LIKE ?"
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  def proper_name
    name
  end

  # Find a users' friends
  def self.friends
    friendships = Friendship.all.where(user_id1: self.id, user_id2: self.id).map{ |f| f.user_id2 }
    for friendship in friendships
        friend = User.where(id: friendship.user_id2)
        friends += friend
    end
    return friends 
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
   update_attribute(:remember_digest, nil)
  end

  #private
  # def self.authenticate(username, password)
  # 	find_by_username(username).try(:authenticate, password)
  # end
  
  

end
