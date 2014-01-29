class Reference < ActiveRecord::Base
  belongs_to :term_reference
  belongs_to :topic
  has_one :book, :through => :term_reference

  attr_accessible :term_reference_id, :topic_id, :indices
end
