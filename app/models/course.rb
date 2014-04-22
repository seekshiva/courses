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
    self.terms.select(&:current?)
  end

  def this_year
    self.terms.select(&:this_year?)
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
      about:   Kramdown::Document.new(about || "").to_html
    }

    if options[:include]
      unless options[:include][:term].nil?
        term = options[:include][:term]
        course[:term_id] = term.id
        course[:instructors] = term.faculties.collect { |f| f.as_json(exclude: [:about]) }
      end

      unless options[:include][:all].nil?
        course[:departments]     = self.departments
        course[:sections]        = latest_term.sections.as_json(generic: true)
        course[:reference_books] = books.as_json
      end
    end

    course.except(options[:exclude])
  end
  
end
