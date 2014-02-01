class SectionDocument < ActiveRecord::Base
  attr_accessible :section_id, :document_id

  validates :section_id, uniqueness: { scope: :document_id}
end
