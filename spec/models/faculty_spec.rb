require 'spec_helper'

describe Faculty do
  it { should belong_to(:user) }

  it { should validate_uniqueness_of(:user_id) }

  it { should allow_mass_assignment_of(:prefix) }
  it { should allow_mass_assignment_of(:user_id) }
  it { should allow_mass_assignment_of(:designation) }
  it { should allow_mass_assignment_of(:about) }

  it "has a full name" do
    user = FactoryGirl.create(:user, name: "John Doe")
    faculty = FactoryGirl.create(:faculty, user: user, prefix: "NewPrefix.")

    faculty.full_name.should eq "NewPrefix. John Doe"
  end

  it "has a department" do
    dept = FactoryGirl.create(:department)
    user = FactoryGirl.create(:user, department: dept)
    faculty = FactoryGirl.create(:faculty, user: user)
    
    faculty.department.should eq dept
  end
end
