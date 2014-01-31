require 'spec_helper'

describe Term do
  it { should belong_to(:course) }

  it { should have_many(:sections).dependent(:destroy) }
  it { should have_many(:topics).through(:sections).dependent(:destroy) }

  it { should have_many(:term_departments).dependent(:destroy) }
  it { should have_many(:departments).through(:term_departments) }

  it { should have_many(:term_faculties).dependent(:destroy) }
  it { should have_many(:faculties).through(:term_faculties) }

  it { should have_many(:term_references).dependent(:destroy) }
  it { should have_many(:books).through(:term_references) }

  it { should have_many(:subscriptions).dependent(:destroy) }
  it { should have_many(:users).through(:subscriptions) }

  it { should have_many(:term_documents).dependent(:destroy) }
  it { should have_many(:documents).through(:term_documents) }
    
  it { should allow_mass_assignment_of(:course_id) }
  it { should allow_mass_assignment_of(:academic_year) }
  it { should allow_mass_assignment_of(:semester) }

  it "has a year" do 
    course = FactoryGirl.build(:course)
    year = Time.now.year.to_i
    term = FactoryGirl.build(:term, course: course, academic_year: year )
    term.year.should eq year.to_s+"-"+(year+1).to_s
  end

  context "#current?" do
    it "returns true if term is current" do
      course = FactoryGirl.build(:course)
      year = Time.now.year.to_i
      year -= Time.now.month<6 ? 1 : 0
      semester = Time.now.month<6 ? 2 : 1
      term = FactoryGirl.build(:term, course: course, academic_year: year, semester: semester)
      term.current?.should be_true
    end

    it "returns false if term is not current" do
      course = FactoryGirl.build(:course)
      term = FactoryGirl.build(:term, course: course, academic_year: (Time.now.year.to_i-2) )
      term.current?.should be_false
    end
  end

  context "#this_year?" do
    it "returns true if term is this year" do
      course = FactoryGirl.build(:course)
      year = Time.now.year.to_i
      year -= Time.now.month<6 ? 1 : 0
      term = FactoryGirl.build(:term, course: course, academic_year: year)
      term.this_year?.should be_true
    end 

    it "returns false if term is not this year" do 
      course = FactoryGirl.build(:course)
      term = FactoryGirl.build(:term, course: course, academic_year: (Time.now.year.to_i-2) )
      term.this_year?.should be_false
    end
  end

  context "#odd_term?" do
    it "returns true if term is odd" do 
      course = FactoryGirl.build(:course)
      term = FactoryGirl.build(:term, course: course, semester: 1 )
      term.odd_term?.should be_true
    end

    it "returns false if term is even" do
      course = FactoryGirl.build(:course)
      term = FactoryGirl.build(:term, course: course, semester: 2 )
      term.odd_term?.should be_false
    end
  end
end
