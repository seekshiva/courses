class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  belongs_to :avatar
  belongs_to :department

  has_many :subscriptions, :dependent => :destroy
  has_many :terms, :through => :subscriptions

  has_many :courses, :through => :terms

  attr_accessible :name, :email, :department_id, :phone, :avatar_id, :activated, :admin, :doc_access_token, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip

  validates :email, :uniqueness => true

  def admin?
    self.admin == true
  end
  
  def activated?
    self.activated == true
  end
  
  def student?
    return self[:email].to_i.to_s == self[:email]
  end
  
  def nth_year
    if self.student?
      return Time.now.year%100 - self[:email][4..5].to_i
    else
      nil
    end
  end

  def update_access_token
    if (!self.current_sign_in_at.nil? && self.current_sign_in_at - Time.now() > 1.week) || self.doc_access_token.nil?
      self.update_attributes doc_access_token: Digest::MD5.hexdigest(self.email+Time.now().to_s)
    end
  end

end
