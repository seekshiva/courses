class Book < ActiveRecord::Base
  attr_accessible :short, :edition, :isbn, :publisher, :title, :year, :cover_url, :download_url, :online_retail_url
  
  has_many :book_authors, :dependent => :destroy
  has_many :authors, :through => :book_authors
end
