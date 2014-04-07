FactoryGirl.define do

  factory :faculty do
    user
    prefix "Ms."
    designation "Professor"
    about BlueCloth.new("Some intro about the prof").to_html
  end

end
