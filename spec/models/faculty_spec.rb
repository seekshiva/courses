require 'spec_helper'

describe Faculty do

  it "should have a factory" do
    FactoryGirl.build(:faculty).should be_valid
  end

  context "associations" do
    it { should belong_to(:user) }
  end

  context "validations" do
    it { should validate_uniqueness_of(:user_id) }
    it { should allow_mass_assignment_of(:prefix) }
    it { should allow_mass_assignment_of(:user_id) }
    it { should allow_mass_assignment_of(:designation) }
    it { should allow_mass_assignment_of(:about) }
  end

  describe "#fullname" do
    it "should return the full name, with prefix" do
      user = FactoryGirl.create(:user, name: "John Doe")
      faculty = FactoryGirl.create(:faculty, user: user, prefix: "NewPrefix.")

      faculty.full_name.should eq "NewPrefix. John Doe"
    end
  end

  describe "#department" do
    it "should return the department of the associated :user" do
      dept = FactoryGirl.create(:department)
      user = FactoryGirl.create(:user, department: dept)
      faculty = FactoryGirl.create(:faculty, user: user)

      faculty.department.should eq dept
    end
  end

  describe "#as_json" do
    before do
      user    = FactoryGirl.create( :user )
      @faculty = FactoryGirl.create( :faculty, user: user )
    end
    
    it "should have key `about`" do
      about = "<p>Some intro about the prof</p>\n"
      @faculty.as_json[:about].should be_eql( about )
    end
    
    it "should have key `email`" do
      mail = "john.doe"
      @faculty.as_json[:email].should be_eql( mail )
    end
    
    it "should have key `instructor`" do
      @faculty.as_json[:instructor].should be_eql( "Ms. John Doe" )
    end

  end

end
