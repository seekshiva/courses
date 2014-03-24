class Faculty < ActiveRecord::Base
  belongs_to :user
  attr_accessible :prefix, :user_id, :designation, :about
  
  validates :user_id, :uniqueness => true

  def department
    Department.find(user.department_id)
  end
  
  def full_name
    "#{prefix} #{user.name}"
  end

  def as_json( options = {} )
    faculty = {
      id:    id,
      name:  full_name,
      email: user.email
    }
    
    unless options[:exclude] == :about
      faculty[:about] = BlueCloth.new(about).to_html
    end
    
    faculty
  end
  
end
