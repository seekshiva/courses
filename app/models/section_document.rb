class SectionDocument < ActiveRecord::Base
  belongs_to :section
  belongs_to :document

  attr_accessible :section_id, :document_id

  validates :section_id, uniqueness: { scope: :document_id}
end
