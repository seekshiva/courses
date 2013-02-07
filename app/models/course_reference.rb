class CourseReference < ActiveRecord::Base
  belongs_to :course
  belongs_to :book
  attr_accessible :book_id, :course_id
  
  validates_uniqueness_of :book_id, :scope => :course_id
end
