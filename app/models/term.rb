class Term < ActiveRecord::Base
  belongs_to :course

  has_many :sections, :dependent => :destroy
  has_many :topics, :through => :sections

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

  has_many :classes, foreign_key: "term_id", class_name: "Classroom"

  attr_accessible :course_id, :academic_year, :semester

  default_scope { order("semester ASC") }
  
  def year
    return "#{self.academic_year}-#{self.academic_year+1}"
  end
  
  def current?
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

  def odd_term?
    self.semester%2 == 0 ? false : true
  end

  def subscription_for(user)
    return nil if user.nil?

    subscription = subscriptions.where(:user_id => user.id).first

    if subscription.nil?
      { id: nil, attending: nil }
    else
      { id: subscription.id, attending: subscription.attending }
    end
  end

  def as_json( args = {} )

    if args[:current_user]          # Return with detailed term info
      {
        id:              id,
        course:          course.as_json,
        departments:     departments,
        classes:         classes.map         { |cl|            cl.as_json },
        sections:        sections.map        { |section|  section.as_json },
        attachments:     documents.map       { |doc|          doc.as_json },
        instructors:     faculties.map       { |faculty|  faculty.as_json },
        reference_books: term_references.map { |item|        item.as_json },
        attendees:       subscriptions.map   { |sub|     sub.user.as_json(only: [:name, :email]) },
        subscription:    subscription_for( args[:current_user] ),
        faculty:         args[:current_user].faculty?
      }

    else                            # Return with high-level overview
      self.course.as_json(exclude: [:about], include: {term: self})
    end
  end

end
