class User < ActiveRecord::Base
  belongs_to :department
  attr_accessible :designation, :email, :mobile, :name, :profile_pic, :department_id
end
