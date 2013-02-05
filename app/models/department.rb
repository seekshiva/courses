class Department < ActiveRecord::Base
  attr_accessible :short, :hod, :name
  has_many :course_list_items, :dependent => :destroy
  has_many :courses, :through => :course_list_items

end
