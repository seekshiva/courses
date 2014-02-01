class Author < ActiveRecord::Base
  has_many :book_authors, :dependent => :destroy
  has_many :books, :through => :book_authors
  
  attr_accessible :name, :about
  
  validates :name, :presence => {
    :message => "-> not present"
  }
  validates :name, :uniqueness => true
end
