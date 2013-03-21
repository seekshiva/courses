class Department < ActiveRecord::Base
  attr_accessible :short, :hod, :name, :rollno_prefix

  has_many :term_departments, :dependent => :destroy
  has_many :terms, :through => :term_departments
  has_many :courses, :through => :term_departments

end
