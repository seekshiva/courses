class Department < ActiveRecord::Base
  belongs_to :hod, :class_name => "Faculty"

  has_many :term_departments, :dependent => :destroy
  has_many :terms, :through => :term_departments
  has_many :courses, :through => :term_departments

  attr_accessible :name, :short, :rollno_prefix, :hod_id


  def as_json( options = {} )
    dept = {
      id:            self[:id],
      name:          self[:name],
      rollno_prefix: self[:rollno_prefix],
      short:         self[:short],
      hod:           hod_name,
      hod_email:     hod_email
    }

    
    if options[:include] == :course_listing
      dept[:course_listing] = course_listing
    end

    dept
  end

  private
  
  def course_listing

    self.terms.select(&:this_year?).group_by(&:semester).map do |sem, term|
      {
        semester:    sem,
        course_list: term.as_json
      }
    end

  end

  def hod_name
      if self.hod.nil?
        "-"
      else
        self.hod.full_name
      end
  end
  
  def hod_email
      if self.hod.nil?
        0
      else
        self.hod.user.email
      end
  end

end
