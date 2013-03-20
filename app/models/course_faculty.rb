class CourseFaculty < ActiveRecord::Base
  belongs_to :course
  belongs_to :faculty
  attr_accessible :course_id, :faculty_id
  
  validates_uniqueness_of :course_id, :scope => :faculty_id
end
