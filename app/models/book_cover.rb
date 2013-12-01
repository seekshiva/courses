class BookCover < ActiveRecord::Base
	belongs_to :book

	attr_accessible :cover, :uploaded_by
	
	has_attached_file :cover,
		:styles => { :thumb => "142x200", :large=>"320x320>" },
		:url => '/system/books/cover_pic/:style/:hash.:extension',
		:path => ':rails_root/public/system/books/cover_pic/:style/:hash.:extension',
		:hash_secret => Courses::Application.config.secret_token

end
