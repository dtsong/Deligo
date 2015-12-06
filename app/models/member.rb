class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  
  validates_presence_of :user_id, :group_id
  validates_numericality_of :user_id, only_integer: true 
  validates_numericality_of :group_id, only_integer: true 
  
  validate :member_is_not_a_duplicate, on: :create
  
  
  def already_exists?
    Member.where(user_id: self.user_id, group_id: self.group_id).size == 1
  end
  
  def member_is_not_a_duplicate
    return true if self.user_id.nil? || self.group_id.nil?
    if self.already_exists?
      errors.add(:group_id, "already contains this user")
    end
  end
end
