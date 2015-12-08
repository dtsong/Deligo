class Group < ActiveRecord::Base
  belongs_to :user
  has_many :members
  has_many :users, through: :members
  
  validates_presence_of :creator_id, :name
  validates_numericality_of :creator_id, only_integer: true 
  
  before_save :set_active
  
  scope :for_creator, -> (creator_id) { where("creator_id = ?", creator_id) }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  
  private
  def set_active
    if self.active == nil
      self.active = true
    end
  end
  
end
