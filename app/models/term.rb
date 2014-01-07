class Term < ActiveRecord::Base
  belongs_to :course

  has_many :sections, :dependent => :destroy
  has_many :topics, :through => :sections, :dependent => :destroy

  has_many :term_departments, :dependent => :destroy
  has_many :departments, :through => :term_departments

  has_many :term_faculties, :dependent => :destroy
  has_many :faculties, :through => :term_faculties

  has_many :term_references, :dependent => :destroy
  has_many :books, :through => :term_references

  has_many :subscriptions, :dependent => :destroy
  has_many :users, :through => :subscriptions

  has_many :term_documents, :dependent => :destroy
  has_many :documents, :through => :term_documents

  attr_accessible :course_id, :academic_year, :semester

  default_scope { order("semester ASC") }
  
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
    current_academic_year = Time.now.year.to_i - (Time.now.month<6 ? 1 : 0)
    self.academic_year == current_academic_year
  end

  def is_odd_term?
    self.semester%2 == 0 ? false : true
  end
end
