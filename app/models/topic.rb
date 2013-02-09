class Topic < ActiveRecord::Base
  belongs_to :course
  attr_accessible :course, :description, :title, :ct_status

  has_many :references, :dependent => :destroy
  has_many :course_references, :through => :references
  has_many :books, :through => :course_references
end
