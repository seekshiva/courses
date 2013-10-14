class Section < ActiveRecord::Base
  belongs_to :course
  attr_accessible :course_id, :title

  has_many :topics
end
