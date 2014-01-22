class SectionDocument < ActiveRecord::Base
  validates :document_id, uniqueness: { scope: :section_id }
  attr_accessible :document_id, :section_id
end
