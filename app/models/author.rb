class Author < ActiveRecord::Base
  attr_accessible :name
  
  has_many :book_authors
  has_many :books, :through => :book_authors
  
end
