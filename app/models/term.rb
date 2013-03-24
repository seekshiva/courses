class Term < ActiveRecord::Base
  belongs_to :course

  has_many :term_departments, :dependent => :destroy
  has_many :departments, :through => :term_departments

  has_many :term_faculties, :dependent => :destroy
  has_many :faculties, :through => :term_faculties

  attr_accessible :course_id, :academic_year, :semester

  default_scope :order => "semester ASC"
  
  def year
    return "#{self.academic_year}-#{self.academic_year+1}"
  end
  
  def is_current?
    current_academic_year = Time.now.year.to_i
    current_academic_year -= Time.now.month<6 ? 1 : 0
    if self.academic_year == current_academic_year
      (self.semester%2 == 0 && Time.now.month<6) || (self.semester%2 == 1 && Time.now.month>=6)
    end
  end

  def this_year?
    ret = false
    current_academic_year = Time.now.year.to_i - (Time.now.month<6 ? 1 : 0)
    if self.academic_year == current_academic_year
      ret = true
    end
    ret
  end
end
