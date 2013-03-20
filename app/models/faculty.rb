class Faculty < ActiveRecord::Base
  belongs_to :user
  attr_accessible :prefix, :user_id
  
  validates :user_id, :uniqueness => true
end
