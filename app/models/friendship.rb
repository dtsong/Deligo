class Friendship < ActiveRecord::Base
  belongs_to :user1, class_name: "User"
  belongs_to :user2, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
