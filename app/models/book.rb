class Book < ActiveRecord::Base
  belongs_to :book_cover
  
  has_many :book_authors, :dependent => :destroy
  has_many :authors, :through => :book_authors

  attr_accessible :title, :publisher, :edition, :isbn, :year, :online_retail_url, :book_cover_id, :file_id

  def isbn_10
    Lisbn.new(self.isbn).isbn10
  end

  def isbn_13
    Lisbn.new(self.isbn).isbn13
  end

  def as_json( options = {} )
    {
      id:                  id,
      term_ref_id:         options[:term_ref_id],
      authors:             authors.as_json( only: :name ),
      cover:               book_cover.nil? ? false : book_cover.cover.url(:thumb),
      title:               title,
      publisher:           publisher,
      edition:             edition,
      "isbn-10" =>         isbn_10,
      "isbn-13" =>         isbn_13,
      book_cover_id:       book_cover_id,
      year:                year,
      online_retail_url:   online_retail_url,
    }
  end

end
