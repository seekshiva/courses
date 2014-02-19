require 'spec_helper'

describe User do

  context "associations" do
    it { should belong_to(:avatar) }
    it { should belong_to(:department) }
    it { should have_many(:subscriptions).dependent(:destroy) }
    it { should have_many(:terms).through(:subscriptions) }
    it { should have_many(:courses).through(:terms) }
  end

  context "validations" do
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
    it { should validate_uniqueness_of(:email) }
  end

  describe "#admin?" do
    context "if admin" do
      it "should return true" do
        user = FactoryGirl.build(:admin)
        user.should be_admin
      end
    end
    
    context "if not admin" do
      it "should return false" do
        user = FactoryGirl.build(:user)
        user.should_not be_admin
      end
    end
  end

  describe "#activated?" do
    context "user has logged in before" do
      it "should return true" do
        user = FactoryGirl.build(:user, activated: true)
        user.activated?.should be_true
      end
    end
    
    context "user is logging in for the first time" do
      it "should return false" do
        user = FactoryGirl.build(:user, activated: false)
        user.activated?.should be_false
      end
    end
  end

  describe "#student?" do
    context "if student" do
      it "should return true" do
        user = FactoryGirl.build(:user, email: "106109087")
        user.should be_student
      end
    end
    
    context "if not student" do
      it "should return false" do
        user = FactoryGirl.build(:user, email: "123.some.string.123")
        user.should_not be_student
      end
    end
  end

  describe "#nth_year" do
    context "if student" do
      it " should return year that the student is in" do
        roll_nos = ["110112109", "102111040", "108110110", "106109087"]
        roll_nos.each do |roll_no|
          user = FactoryGirl.build(:user, email: roll_no)
          user.nth_year.should be Time.now.year%100 - user[:email][4..5].to_i
        end
      end
    end

    context "if not student" do
      it "should return nil" do
        user = FactoryGirl.build(:user, email: "faculty.mail")
        user.nth_year.should be_nil
      end
    end
  end

  describe "#update_access_token" do
    pending "write spec for this method"
  end
end
