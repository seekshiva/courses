class Section < ActiveRecord::Base
  belongs_to :term
  attr_accessible :term_id, :title

  has_many :topics
end
