class Section < ActiveRecord::Base
  belongs_to :term
  has_many :topics

  attr_accessible :term_id, :title

  validates :term_id, :uniqueness => { scope: :title }
end
