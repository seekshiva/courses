class File < ActiveRecord::Base
  attr_accessible :file, :uploaded_by
  has_attached_file :file ,
  	:url => '/system/files/:hash.:extension',
	:path => ':rails_root/public/system/files/:hash.:extension',
	:hash_secret => Courses::Application.config.secret_token
end
