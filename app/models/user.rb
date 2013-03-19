class User < ActiveRecord::Base
  belongs_to :department
  attr_accessible :designation, :email, :mobile, :name, :profile_pic, :department_id
  
  def is_student?
    return self[:email].to_i != 0
  end
  
  def nth_year
    if self.is_student?
      return Time.now.year%100 - self[:email][4..5].to_i
    else
      nil
    end
  end
end
