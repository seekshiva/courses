class Document < ActiveRecord::Base
  has_attached_file :document,
    :url => '/download/:id',
  	:path => ':rails_root/public/system/files/:hash.:extension',
  	:hash_secret => Courses::Application.config.secret_token

  attr_accessible :document, :uploaded_by
end
