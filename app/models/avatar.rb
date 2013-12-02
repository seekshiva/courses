class Avatar < ActiveRecord::Base
  attr_accessible :pic
  has_attached_file :pic,
	:styles => { :thumb => "32x32", :small => "50x50#", :medium=>"160x160#", :large=>"320x320>" },
	:url => '/system/users/:style/:hash.:extension',
	:path => ':rails_root/public/system/users/:style/:hash.:extension',
	:hash_secret => Courses::Application.config.secret_token
end
