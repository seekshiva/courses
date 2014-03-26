class TermFaculty < ActiveRecord::Base
  belongs_to :term
  belongs_to :faculty

  attr_accessible :term_id, :faculty_id, :faculty_email
  
  validates_uniqueness_of :term_id, :scope => :faculty_id

  def as_json
    {
      term_id:      term_id,
      course_name:  term.course.name,
      course_id:    term.course_id,
      current:      term.current?
    }
  end
end
