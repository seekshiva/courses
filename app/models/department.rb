class Department < ActiveRecord::Base
  attr_accessible :short, :hod_id, :name, :rollno_prefix
  belongs_to :hod, :class_name => "Faculty"

  has_many :term_departments, :dependent => :destroy
  has_many :terms, :through => :term_departments
  has_many :courses, :through => :term_departments

end
