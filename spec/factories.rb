FactoryGirl.define do
  
  # Sequences
  sequence :subject_code, 400 do |n|
    "CS#{n}"
  end


  # Book
  
  factory :book do
    title     "Hitchhiker's Guide to Galaxy"
    publisher "Tor UK"
    edition   "1st edition"
    isbn      "0330316117"
    year       1992
    online_retail_url  "http://www.amazon.in/Hitchhikers-Guide-Galaxy-Douglas-Adam/dp/0330316117"
  end

  # Course

  factory :course do
    subject_code
    name         "Distributed Systems"
    credits       3
    about         ""
  end

  # Department

  factory :department do
    name  "Chemical Engineering"
    short "CHEM"
    rollno_prefix "1021"
  end

  factory :term_department do
    term
    department
  end
  
  # Documents

  factory :document do
    
  end

  factory :term_document do
    term
    document
  end

  factory :section_document do
    section
    document
  end

  factory :topic_document do
    topic
    document
  end

  # References
  
  factory :reference do
    topic
    term_reference
    indices "1.2.3-1.4"
  end
  
  factory :term_reference do
    term
    book
  end

  # Section

  factory :section do
    term
    title "This is a section"
  end

  # Term

  factory :term do
    course
    academic_year  2012
    semester       7
  end

  # Topic

  factory :topic do
    title "This is a topic"
    description "TOpic description"
    ct_status "Post CT"
    section
  end

  # Users

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

  factory :faculty do
    user
    prefix "Ms."
    designation "Professor"
    about BlueCloth.new("Some intro about the prof").to_html
  end

  factory :term_faculty do
    term
    faculty
  end
end
