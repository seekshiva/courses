class Course < ActiveRecord::Base

  has_many :terms, :dependent => :destroy

  has_many :term_departments, :through => :terms
  has_many :departments, :through => :term_departments

  has_many :term_faculties, :through => :terms
  has_many :faculties, :through => :term_faculties

  has_many :term_references, :through => :terms
  has_many :books, :through => :term_references

  has_many :sections, :through => :terms
  has_many :topic, :through => :sections

  default_scope order("subject_code ASC")
  
  attr_accessible :about, :credits, :name, :subject_code

  validates :name, :uniqueness => true

  def current_term
    current = []
    self.terms.each do |term|
      if term.is_current?
        current << term
      end
    end
    current
  end

  def this_year
    current = []
    self.terms.each do |term|
      if term.this_year?
        current << term
      end
    end
    current
  end

  def latest_term
    latest = nil
    self.terms.each do |term|
      latest = term if
        latest.nil? or
        term.academic_year > latest.academic_year or
        (term.academic_year == latest.academic_year and term.semester%2 < latest.semester%2)
    end
    latest
  end
  
end
