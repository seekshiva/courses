class ClassTopic < ActiveRecord::Base
  belongs_to :classroom
  belongs_to :section
  attr_accessible :classroom_id, :section_id

  validates :classroom_id, :uniqueness => { :scope => :section_id }
end
