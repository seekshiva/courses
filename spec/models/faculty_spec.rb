require 'spec_helper'

describe Faculty do

  it "should have a factory" do
    expect(build :faculty).to be_valid
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
      user    = create(:user, name: "John Doe")
      faculty = create(:faculty, user: user, prefix: "NewPrefix.")

      expect(faculty.full_name).to eq "NewPrefix. John Doe"
    end
  end

  describe "#department" do
    it "should return the department of the associated :user" do
      dept    = create(:department)
      user    = create(:user, department: dept)
      faculty = create(:faculty, user: user)

      expect(faculty.department).to eq dept
    end
  end

  describe "#as_json" do
    before do
      user     = create(:user)
      @faculty = create(:faculty, user: user)
    end
    
    it "should have key `name`" do
      expect(@faculty.as_json[:name]).to be_eql( @faculty.full_name )
    end

    it "should have key `email`" do
      expect(@faculty.as_json[:email]).to be_eql( @faculty.user.email )
    end
    
    it "should have key `about`" do
      about = "<p>Some intro about the prof</p>\n"
      expect(@faculty.as_json[:about]).to be_eql( about )
    end
    
  end

end
