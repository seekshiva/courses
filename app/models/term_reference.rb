class TermReference < ActiveRecord::Base
  belongs_to :term
  belongs_to :book
  
  has_many :references
  has_many :topics, :through => :references
  
  attr_accessible :book_id, :term_id

  validates_uniqueness_of :book_id, :scope => :term_id
end
