class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :term

  attr_accessible :attending, :term_id, :user_id
  validates_uniqueness_of :term_id, :scope => :user_id

  def as_json
    {
      id:           id,
      term_id:      term.id,
      user_id:      user.id,
      attending:    attending,
      course_name:  term.course.name,
      course_id:    term.course_id,
      current:      term.current?
    }
  end
end
