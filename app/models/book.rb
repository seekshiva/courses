class Book < ActiveRecord::Base
  attr_accessible :short, :edition, :isbn, :publisher, :title, :year
  
  has_many :book_authors, :dependent => :destroy
  has_many :authors, :through => :book_authors
end
