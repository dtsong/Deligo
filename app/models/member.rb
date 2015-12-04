class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  
  validates_presence_of :user_id, :group_id
  validates_numericality_of :user_id, only_integer: true 
  validates_numericality_of :group_id, only_integer: true 
  
end
