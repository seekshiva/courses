require 'spec_helper'

describe Term do

  it "should have a factory" do
    FactoryGirl.build(:term).should be_valid
  end

  context "associations" do
    it { should belong_to(:course) }
    it { should have_many(:sections).dependent(:destroy) }
    it { should have_many(:topics).through(:sections) }
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
  end

  context "validations" do
    it { should allow_mass_assignment_of(:course_id) }
    it { should allow_mass_assignment_of(:academic_year) }
    it { should allow_mass_assignment_of(:semester) }
  end

  describe ".year" do
    it "should return the academic year (format: 2013-2014)" do
      course = FactoryGirl.build(:course)
      year = Time.now.year.to_i
      term = FactoryGirl.build(:term, course: course, academic_year: year )
      term.year.should eq year.to_s+"-"+(year+1).to_s
    end
  end

  describe "#current?" do
    context "if term happens in current semester" do
      it "should return true" do
        course = FactoryGirl.build(:course)
        year = Time.now.year.to_i
        year -= Time.now.month<6 ? 1 : 0
        semester = Time.now.month<6 ? 2 : 1
        term = FactoryGirl.build(:term, course: course, academic_year: year, semester: semester)
        term.current?.should be_true
      end
    end

    context "if term is doesn't happen in current semester" do
      it "should return false" do
        course = FactoryGirl.build(:course)
        term = FactoryGirl.build(:term, course: course, academic_year: (Time.now.year.to_i-2) )
        term.current?.should be_false
      end
    end
  end

  describe "#this_year?" do
    context "if term happens in current academic year" do
      it "should return true" do
        course = FactoryGirl.build(:course)
        year = Time.now.year.to_i
        year -= Time.now.month<6 ? 1 : 0
        term = FactoryGirl.build(:term, course: course, academic_year: year)
        term.this_year?.should be_true
      end
    end

    context "if term doesn't happen in current academic year" do
      it "should return false" do
        course = FactoryGirl.build(:course)
        term = FactoryGirl.build(:term, course: course, academic_year: (Time.now.year.to_i-2) )
        term.this_year?.should be_false
      end
    end
  end

  describe "#odd_term?" do
    context "if term happens in odd semester" do
      it "should return true" do
        course = FactoryGirl.build(:course)
        term = FactoryGirl.build(:term, course: course, semester: 1 )
        term.odd_term?.should be_true
      end
    end

    context "if term happens in even semester" do
      it "should return false" do
        course = FactoryGirl.build(:course)
        term = FactoryGirl.build(:term, course: course, semester: 2 )
        term.odd_term?.should be_false
      end
    end
  end
end
