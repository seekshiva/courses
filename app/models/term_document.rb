class TermDocument < ActiveRecord::Base
  belongs_to :term
  belongs_to :document
  
  attr_accessible :document_id, :term_id

  validates :term_id, :uniqueness => { scope: :document_id }
end
