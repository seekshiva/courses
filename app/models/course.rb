class Course < ActiveRecord::Base
  attr_accessible :credits, :name, :subject_code
  has_many :terms, :dependent => :destroy
  has_many :topics, :dependent => :destroy

  has_many :course_references, :dependent => :destroy
  has_many :books, :through => :course_references

  has_many :course_list_items, :dependent => :destroy
  has_many :departments, :through => :course_list_items
  
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
    current=nil
    self.terms.each do |term|
      if term.this_year?
        if current.nil? or not current.is_current?
          current = term
        end
      end
    end
    current
  end
end
