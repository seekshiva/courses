class Book < ActiveRecord::Base
  belongs_to :book_cover
  
  has_many :book_authors, :dependent => :destroy
  has_many :authors, :through => :book_authors

  attr_accessible :title, :publisher, :edition, :isbn, :year, :online_retail_url, :book_cover_id, :file_id
end
