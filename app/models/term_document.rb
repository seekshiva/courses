class TermDocument < ActiveRecord::Base
  belongs_to :term
  belongs_to :document

  validates :document_id, uniqueness: { scope: :term_id }
  
  attr_accessible :document_id, :term_id
end
