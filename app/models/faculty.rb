class Faculty < ActiveRecord::Base
  belongs_to :user
  attr_accessible :prefix, :user_id
  
  validates :user_id, :uniqueness => true

  def department
    Department.find(self.user.department_id)
  end
  
  def full_name
    "#{self.prefix} #{self.user.name}"
  end
end
