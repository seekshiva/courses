require 'spec_helper'

describe Subscription do

  xit "should have a factory" do
    FactoryGirl.build(:subscription).should be_valid
  end

  context "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:term) }
  end

  context "validations" do
    it { should allow_mass_assignment_of(:attending) }
    it { should allow_mass_assignment_of(:term_id) }
    it { should allow_mass_assignment_of(:user_id) }
    it { should validate_uniqueness_of(:term_id).scoped_to(:user_id) }
  end

end
