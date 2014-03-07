require 'spec_helper'

describe User do

  it { should belong_to(:avatar) }
  it { should belong_to(:department) }

  it { should have_many(:subscriptions).dependent(:destroy) }
  it { should have_many(:terms).through(:subscriptions) }

  it { should have_many(:courses).through(:terms) }
  
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:department_id) }
  it { should allow_mass_assignment_of(:phone) }
  it { should allow_mass_assignment_of(:avatar_id) }
  it { should allow_mass_assignment_of(:activated) }
  it { should allow_mass_assignment_of(:admin) }
  it { should allow_mass_assignment_of(:doc_access_token) }
  it { should allow_mass_assignment_of(:sign_in_count) }
  it { should allow_mass_assignment_of(:current_sign_in_at) }
  it { should allow_mass_assignment_of(:last_sign_in_at) }
  it { should allow_mass_assignment_of(:current_sign_in_ip) }
  it { should allow_mass_assignment_of(:last_sign_in_ip) }
  it { should allow_mass_assignment_of(:blacklist) }
  it { should allow_mass_assignment_of(:blacklist_log) }

  it { should validate_uniqueness_of(:email) }

  context "#admin?" do
    it "return true if user is admin" do
      user = FactoryGirl.build(:admin)
      user.should be_admin
    end
    
    it "return false if user is not admin" do
      user = FactoryGirl.build(:user)
      user.should_not be_admin
    end
  end

  context "#activated?" do
    it "return true if user has logged in before" do
      user = FactoryGirl.build(:user, activated: true)
      user.activated?.should be_true
    end
    
    it "return false if user is logging in for the first time" do
      user = FactoryGirl.build(:user, activated: false)
      user.activated?.should be_false
    end
  end

  context "#student?" do
    it "return true if user is a student" do
      user = FactoryGirl.build(:user, email: "106109087")
      user.should be_student
    end
    
    it "return false if user is not a student" do
      user = FactoryGirl.build(:user, email: "123.some.string.123")
      user.should_not be_student
    end
  end

  context "#nth_year" do
    context "faculty" do
      it "return nil if user is faculty" do
        user = FactoryGirl.build(:user, email: "faculty.mail")
        user.nth_year.should be_nil
      end
    end

    context "student" do
      it "return year if user is student" do
        roll_nos = ["110112109", "102111040", "108110110", "106109087"]
        roll_nos.each do |roll_no|
          user = FactoryGirl.build(:user, email: roll_no)
          user.nth_year.should be Time.now.year%100 - user[:email][4..5].to_i
        end
      end
    end
  end

  context "#update_access_token" do
    pending
  end
end
