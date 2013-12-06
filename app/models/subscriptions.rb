class Subscriptions < ActiveRecord::Base
  belongs_to :user_id
  belongs_to :term_id

  attr_accessible :attending, :term_id
  validates_uniqueness_of :term_id, :scope => :user_id

end
