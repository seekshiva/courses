class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  belongs_to :department

  has_one :avatar, :dependent => :destroy

  has_many :subscriptions, :dependent => :destroy
  has_many :terms, :through => :subscriptions

  has_many :courses, :through => :terms

  belongs_to :avatar

  attr_accessible :name, :email, :department_id, :phone, :avatar_id, :activated, :admin

  validates :email, :uniqueness => true

  def admin?
    self.admin == true
  end
  
  def account_activated?
    self.activated == true
  end
  
  def is_student?
    return self[:email].to_i != 0
  end
  
  def nth_year
    if self.is_student?
      return Time.now.year%100 - self[:email][4..5].to_i
    else
      nil
    end
  end

end
