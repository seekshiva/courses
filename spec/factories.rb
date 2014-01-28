FactoryGirl.define do
  factory :department do
    name  "Chemical Engineering"
    short "CHEM"
    rollno_prefix "1021"
  end

  factory :user do
    name      "John Doe"
    email     "john.doe"
    phone     "9876543210"
    activated  true
    admin      false
    department
  end

  factory :admin, class: User do
    name   "Admin SuperName"
    email  "me.admin"
    admin  true
  end
end
