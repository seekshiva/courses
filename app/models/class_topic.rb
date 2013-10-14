class ClassTopic < ActiveRecord::Base
  belongs_to :classroom
  belongs_to :topic
  attr_accessible :classroom_id, :topic_id

  validates :classroom_id, :uniqueness => { :scope => :section_id }
end
