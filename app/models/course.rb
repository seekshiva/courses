class Course < ActiveRecord::Base

  has_many :terms, :dependent => :destroy

  has_many :subscriptions, :through => :terms
  has_many :users, :through => :subscriptions

  has_many :term_departments, :through => :terms
  has_many :departments, :through => :term_departments

  has_many :term_faculties, :through => :terms
  has_many :faculties, :through => :term_faculties

  has_many :term_references, :through => :terms
  has_many :books, :through => :term_references

  has_many :sections, :through => :terms
  has_many :topics, :through => :sections

  default_scope { order("subject_code ASC") }
  
  attr_accessible :subject_code, :name, :credits, :about

  validates :subject_code, :name, :presence => {
    :message => "-> not present"
  }
  validates :subject_code, :uniqueness => true
  validates :credits, :numericality => {:greater_than_or_equal_to => 0} # zero credit courses can exist

  def current_term
    current = []
    self.terms.each do |term|
      if term.current?
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

  def as_json( options = {} )
    course = {
      id:      id,
      code:    subject_code,
      name:    name,
      credits: credits,
    }

    unless options[:exclude] == :about
      course[:about] = BlueCloth.new(about).to_html
    end

    if options[:include]
      unless options[:include][:term].nil?
        term = options[:include][:term]
        course[:term_id] = term.id
        course[:instructors] = term.faculties.collect { |f| f.as_json(exclude: :about) }
      end
    end

    course
  end
  
end
