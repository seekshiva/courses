require 'spec_helper'

describe Faculty do

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
end
