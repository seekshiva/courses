require 'spec_helper'

describe Faculty do
  it "has unique {user}" do
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:faculty, user: user)

    expect {
      FactoryGirl.create(:faculty, user: user)
    }.to raise_exception
  end

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
