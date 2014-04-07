FactoryGirl.define do

  sequence :name do |n|
    "First Last_#{n}"
  end

  sequence :email do |n|
    "user.mail.#{n}"
  end

  factory :user do
    name
    email
    phone     "9876543210"
    activated  true
    admin      false
    department
  end

  factory :admin, class: User do
    admin  true
  end

end
