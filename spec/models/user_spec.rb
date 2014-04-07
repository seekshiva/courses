require 'spec_helper'

describe User do

  it "should have a factory" do
    expect(build :user).to be_valid
  end

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
        user = build(:admin)
        expect(user).to be_admin
      end
    end
    
    context "if not admin" do
      it "should return false" do
        user = build(:user)
        expect(user).to_not be_admin
      end
    end
  end

  describe "#activated?" do
    context "user has logged in before" do
      it "should return true" do
        user = build(:user, activated: true)
        expect(user.activated?).to be_true
      end
    end
    
    context "user is logging in for the first time" do
      it "should return false" do
        user = build(:user, activated: false)
        expect(user.activated?).to be_false
      end
    end
  end

  describe "#student?" do
    context "if student" do
      it "should return true" do
        user = build(:user, email: "106109087")
        expect(user).to be_student
      end
    end
    
    context "if not student" do
      it "should return false" do
        user = build(:user, email: "123.some.string.123")
        expect(user).to_not be_student
      end
    end
  end

  describe "#faculty?" do
    context "if email in faculty table" do
      context "if student" do
        it "should return true" do
          user = create(:user, email: "106109087")
          faculty = create(:faculty, user: user)

          expect(user).to be_faculty
        end
      end

      context "if not student" do
        it "should return true" do
          user = create(:user, email: "faculty_1")
          faculty = create(:faculty, user: user)

          expect(user).to be_faculty
        end
      end
    end
    
    context "if email not in faculty table" do
      context "if student" do
        it "should return true" do
          user = create(:user, email: "106109088")
          expect(user).to_not be_faculty
        end
      end

      context "if not student" do
        it "should return true" do
          user = create(:user, email: "faculty_2")
          expect(user).to_not be_faculty
        end
      end
    end
  end

  describe "#nth_year" do
    context "if student" do
      it "should return year that the student is in" do
        roll_nos = ["110112109", "102111040", "108110110", "106109087"]
        roll_nos.each do |roll_no|
          user = build(:user, email: roll_no)
          expect(user.nth_year).to be Time.now.year%100 - user[:email][4..5].to_i
        end
      end
    end

    context "if not student" do
      it "should return nil" do
        user = build(:user, email: "faculty.mail")
        expect(user.nth_year).to be_nil
      end
    end
  end

  describe "#update_access_token" do
    pending "write spec for this method"
  end
end
