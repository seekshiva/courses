class BookCover < ActiveRecord::Base
	has_one :book

	attr_accessible :cover, :uploaded_by
	
	has_attached_file :cover,
		:styles => { :thumb => "140x200#", :large=>"213x300#" },
		:url => '/system/books/cover_pic/:style/:hash.:extension',
		:path => ':rails_root/public/system/books/cover_pic/:style/:hash.:extension',
		:hash_secret => Courses::Application.config.secret_token

  validates_attachment_content_type :cover, :content_type => %w(image/jpeg image/jpg image/png)

end
