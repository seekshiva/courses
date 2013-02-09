class Book < ActiveRecord::Base
  attr_accessible :short, :edition, :isbn, :publisher, :title, :year
  
  has_many :book_authors
  has_many :authors, :through => :book_authors
end
