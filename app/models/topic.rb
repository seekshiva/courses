class Topic < ActiveRecord::Base
  belongs_to :section

  has_many :references, :dependent => :destroy
  has_many :term_references, :through => :references
  has_many :books, :through => :term_references

  has_many :notes, foreign_key: "topic_id", class_name: "TopicDocument", :dependent => :destroy
  has_many :documents, :through => :notes

  has_many :class_topics, :dependent => :destroy
  has_many :classrooms, :through => :class_topics

  attr_accessible :title, :description, :ct_status, :section_id
  
  def as_json( options = {} )
    {
      id:          id,
      title:       title,
      description: description,
      ct_status:   ct_status,
      notes:       notes.as_json,
      references:  references.as_json,
      classes:     classrooms.as_json
    }
  end
  
end
