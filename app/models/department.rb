class Department < ActiveRecord::Base
  attr_accessible :name, :short, :rollno_prefix, :hod_id
  belongs_to :hod, :class_name => "Faculty"

  has_many :term_departments, :dependent => :destroy
  has_many :terms, :through => :term_departments
  has_many :courses, :through => :term_departments

end
