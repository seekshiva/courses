class Topic < ActiveRecord::Base
  belongs_to :section

  has_many :references, :dependent => :destroy
  has_many :term_references, :through => :references
  has_many :books, :through => :term_references

  has_many :topic_documents, :dependent => :destroy
  has_many :documents, :through => :topic_documents

  has_many :class_topics, :dependent => :destroy
  has_many :classrooms, :through => :class_topics

  attr_accessible :title, :description, :ct_status, :section_id
end
