class Reference < ActiveRecord::Base
  belongs_to :course_reference
  belongs_to :topic
  attr_accessible :course_reference_id, :topic_id, :indices

  has_one :book, :through => :course_reference
end
