class TermDepartment < ActiveRecord::Base
  belongs_to :term
  belongs_to :department
  
  has_one :course, :through => :term
  attr_accessible :term_id, :department_id
  
  validates_uniqueness_of :term_id, :scope => :department_id
end
