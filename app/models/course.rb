class Course < ActiveRecord::Base
  attr_accessible :about, :credits, :name, :subject_code

  has_many :terms, :dependent => :destroy
  has_many :sections, :dependent => :destroy
  has_many :topics, :dependent => :destroy

  has_many :course_references, :dependent => :destroy
  has_many :books, :through => :course_references

  has_many :departments, :through => :terms

  has_many :course_faculties, :dependent => :destroy
  has_many :faculties, through: :terms

  default_scope order("subject_code ASC")
  
  validates :name, :uniqueness => true

  def current_term
    current = nil
    self.terms.each do |term|
      if term.is_current?
        current = term
      end
    end
    current
  end

  def this_year
    current=[]
    self.terms.each do |term|
      if term.this_year?
        current << term
      end
    end
    current
  end

end
