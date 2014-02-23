class Classroom < ActiveRecord::Base
  belongs_to :term
  attr_accessible :date, :room, :time, :term_id
  
  has_many :class_topics, :dependent => :destroy
  has_many :topics, :through => :class_topics
  has_many :sections, :through => :topics

  def as_json
    {
      id:     id,
      date:   date.strftime("%D"),
      date2: "#{date.strftime('%-d').to_i.ordinalize} #{date.strftime('%b')}",
      time:   time,
      venue:  room
    }
  end
end
