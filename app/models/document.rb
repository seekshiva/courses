class Document < ActiveRecord::Base
  
  belongs_to :user, foreign_key: "uploaded_by"
  
  has_many :topic_documents, :dependent => :destroy
  has_many :topics, :through => :topic_documents

  has_one :term_document, :dependent => :destroy
  has_one :term, :through => :term_document

  has_attached_file :document,
    :url => '/download/:id',
    :path => ':rails_root/public/system/files/:hash.:extension',
    :hash_secret => Courses::Application.config.secret_token
  
  validates_attachment_content_type :document, :content_type => %w(image/jpeg image/jpg image/png application/epub+zip application/mp4 application/msword application/pdf application/vnd.ms-excel application/vnd.ms-powerpoint application/vnd.openxmlformats-officedocument.wordprocessingml.document application/vnd.openxmlformats-officedocument.spreadsheetml.template application/vnd.openxmlformats-officedocument.spreadsheetml.sheet application/vnd.openxmlformats-officedocument.presentationml.presentation audio/mpeg video/mpeg video/webm text/plain audio/x-wav)

  attr_accessible :document, :uploaded_by, :no_of_hits

end
