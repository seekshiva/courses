class Author < ActiveRecord::Base
  attr_accessible :name
  
  has_many :book_authors, :dependent => :destroy
  has_many :books, :through => :book_authors
  
end
