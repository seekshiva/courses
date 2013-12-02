class Book < ActiveRecord::Base
  attr_accessible :short, :edition, :isbn, :publisher, :title, :year, :book_cover_id, :download_url, :online_retail_url
  
  has_many :book_authors, :dependent => :destroy
  has_many :authors, :through => :book_authors

  belongs_to :book_cover
end
