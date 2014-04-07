FactoryGirl.define do
  
  sequence :subject_code, 400 do |n|
    "CS#{n}"
  end

  factory :course do
    subject_code
    name         "Distributed Systems"
    credits       3
    about         ""
  end

end
