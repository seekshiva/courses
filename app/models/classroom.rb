class Classroom < ActiveRecord::Base
  belongs_to :term
  attr_accessible :date, :room, :time, :term_id
  
  has_many :class_topics, :dependent => :destroy
  has_many :topics, :through => :class_topics
end
