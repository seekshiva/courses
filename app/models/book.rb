class Book < ActiveRecord::Base
  attr_accessible :title, :publisher, :edition, :isbn, :year, :online_retail_url, :book_cover_id, :file_id
  
  has_many :book_authors, :dependent => :destroy
  has_many :authors, :through => :book_authors

  belongs_to :book_cover
end
