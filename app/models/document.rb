class Document < ActiveRecord::Base
  attr_accessible :document, :uploaded_by
  has_attached_file :document ,
    :url => '/system/files/:hash.:extension',
  	:path => ':rails_root/public/system/files/:hash.:extension',
  	:hash_secret => Courses::Application.config.secret_token

end
