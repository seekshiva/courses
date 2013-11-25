class TermReference < ActiveRecord::Base
  belongs_to :term
  belongs_to :book
  attr_accessible :book_id, :term_id
  
  has_many :references
  has_many :topics, :through => :references
  
  validates_uniqueness_of :book_id, :scope => :term_id
end
