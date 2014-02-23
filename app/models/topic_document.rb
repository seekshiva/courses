class TopicDocument < ActiveRecord::Base
  belongs_to :document
  belongs_to :topic
  
  attr_accessible :document_id, :topic_id

  def as_json
    {
      :id => id,
      :note_id => document.id,
      :name => document.document.original_filename,
      :url => document.document.url
    }
  end
end
