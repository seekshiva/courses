class Avatar < ActiveRecord::Base
  has_one :user
  has_attached_file :pic,
    :styles => { :thumb => "32x32", :small => "50x50#", :medium=>"160x160#", :large=>"215x215#" },
    :url => '/system/users/:style/:hash.:extension',
    :path => ':rails_root/public/system/users/:style/:hash.:extension',
    :hash_secret => Courses::Application.config.secret_token
  validate :file_dimensions
  validates_attachment :pic, :presence => true,
    :content_type => { :content_type => [ 'image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/bmp'] },
    :size => { :in => 0..6000.kilobytes }
  
  attr_accessible :pic

  validates_attachment_content_type :pic, :content_type => %w(image/jpeg image/jpg image/png)

  def file_dimensions
    dimensions = Paperclip::Geometry.from_file(pic.queued_for_write[:original].path)
    if dimensions.width > 4096 && dimensions.height > 2160
      errors.add(:pic,'Width or height must not exceed 4096*2160')
      return false
    end
  end
end