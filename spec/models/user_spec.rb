require 'spec_helper'

describe User do
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

  context "#account_activated?" do
    it "return true if user has logged in before" do
      user = FactoryGirl.build(:user, activated: true)
      user.account_activated?.should be_true
    end
    
    it "return false if user is logging in for the first time" do
      user = FactoryGirl.build(:user, activated: false)
      user.account_activated?.should be_false
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
end
