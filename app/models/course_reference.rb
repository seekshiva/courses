class CourseReference < ActiveRecord::Base
  belongs_to :course
  belongs_to :book
  attr_accessible :book_id, :course_id
  
  has_many :references
  has_many :topics, :through => :references
  
  validates_uniqueness_of :book_id, :scope => :course_id
end
