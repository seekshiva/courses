class Reference < ActiveRecord::Base
  belongs_to :term_reference
  belongs_to :topic
  has_one :book, :through => :term_reference

  attr_accessible :term_reference_id, :topic_id, :indices

  def as_json
    {
      :id => self.id,
      :term_ref_id => self.term_reference.id,
      :book_id => self.term_reference.book.id,
      :book => self.term_reference.book.title,
      :indices => self.indices
    }
  end

end
