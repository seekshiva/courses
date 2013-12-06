class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :term

  attr_accessible :attending, :term_id, :user_id
  validates_uniqueness_of :term_id, :scope => :user_id

end
