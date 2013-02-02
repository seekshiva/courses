class Term < ActiveRecord::Base
  belongs_to :course
  attr_accessible :course, :academic_year, :semester
end
