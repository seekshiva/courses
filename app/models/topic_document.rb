class TopicDocument < ActiveRecord::Base
  belongs_to :document
  belongs_to :topic
  
  attr_accessible :document_id, :topic_id
end
