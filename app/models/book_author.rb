class BookAuthor < ActiveRecord::Base
  belongs_to :book
  belongs_to :author
  
  attr_accessible :book_id, :author_id

  validates_uniqueness_of :book_id, :scope => :author_id
end
