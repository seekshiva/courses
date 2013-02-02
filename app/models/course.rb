class Course < ActiveRecord::Base
  attr_accessible :credits, :name, :subject_code
  has_many :term
  has_many :topic
end
