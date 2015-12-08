class Friendship < ActiveRecord::Base
  # Relationships
  belongs_to :user1, class_name: "User"
  belongs_to :user2, class_name: "User"

  # Scopes
  scope :friends_of_user, -> (user_id1) { where("user_id1 = ?", user_id1) }
end
