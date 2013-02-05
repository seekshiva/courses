class Term < ActiveRecord::Base
  belongs_to :course
  has_many :departments
  attr_accessible :course_id, :academic_year, :semester
  
  def is_current?
    current_academic_year = Time.now.year.to_i
    current_academic_year -= Time.now.month<6 ? 1 : 0
    if self.academic_year == current_academic_year
      (self.semester%2 == 0 && Time.now.month<6) || (self.semester%2 == 1 && Time.now.month>=6)
    end
  end

  def this_year?
    current_academic_year = Time.now.year.to_i
    current_academic_year -= Time.now.month<6 ? 1 : 0
    if self.academic_year == current_academic_year
      true
    else
      false
    end
  end
end
