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
  
  attr_accessible :document, :uploaded_by, :no_of_hits

  def as_json(options = {})
    {
      id:         self.id,
      name:       self.document.original_filename,
      url:        self.document.url
    }
  end

end
