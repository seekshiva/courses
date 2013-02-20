class Classroom < ActiveRecord::Base
  belongs_to :term
  attr_accessible :date, :room, :time, :term_id
end
