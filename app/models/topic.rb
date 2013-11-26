class Topic < ActiveRecord::Base
  belongs_to :term
  belongs_to :section

  attr_accessible :title, :description, :ct_status, :section_id

  has_many :references, :dependent => :destroy
  has_many :term_references, :through => :references
  has_many :books, :through => :term_references

  has_many :class_topics, :dependent => :destroy
  has_many :classrooms, :through => :class_topics
end
