class Author < ActiveRecord::Base
  attr_accessible :name, :about
  
  has_many :book_authors, :dependent => :destroy
  has_many :books, :through => :book_authors
  
end
