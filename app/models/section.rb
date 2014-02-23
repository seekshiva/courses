class Section < ActiveRecord::Base
  belongs_to :term
  has_many :topics, dependent: :destroy

  attr_accessible :term_id, :title

  validates :term_id, :uniqueness => { scope: :title }

  def short_title
    if title.length > 30
      "#{section.title[0,28]}..."
    else
      title
    end
  end

  def as_json( options = {} )
    {
      id:               id,
      title:            title,
      short_title:      short_title,
      topics:           topics.map { |topic| topic.as_json }
    }
  end
  
end
