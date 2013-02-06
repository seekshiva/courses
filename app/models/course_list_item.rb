class CourseListItem < ActiveRecord::Base
  belongs_to :department
  belongs_to :course
  attr_accessible :department_id, :course_id

  validates_uniqueness_of :course_id, :scope => :department_id
end
