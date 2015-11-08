class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answer_options
  has_many :pictures
  has_many :answers
end
