class Department < ActiveRecord::Base
  attr_accessible :short, :hod, :name, :rollno_prefix
  has_many :course_list_items, :dependent => :destroy
  has_many :courses, :through => :course_list_items

end
