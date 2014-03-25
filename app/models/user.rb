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
    admin == true
  end
  
  def activated?
    activated == true
  end
  
  def student?
    email.to_i.to_s == email
  end

  def faculty?
    not faculty.nil?
  end
  
  def faculty
    Faculty.find_by(user: self)
  end
  
  def nth_year
    (Time.now.year%100 - email[4..5].to_i) if student?
  end

  def update_access_token
    if ( ( !current_sign_in_at.nil? && current_sign_in_at < 1.week.ago ) || doc_access_token.nil? )
      update_attributes doc_access_token: Digest::MD5.hexdigest( email + Time.now().to_s )
    end
  end

end
