require 'spec_helper'

describe Reference do

  it "should have a factory" do
    expect(build :reference).to be_valid
  end

  context "associations" do
    it { should belong_to(:term_reference) }
    it { should belong_to(:topic) }
    it { should have_one(:book).through(:term_reference) }
  end

  context "validations" do
    it { should allow_mass_assignment_of(:term_reference_id) }
    it { should allow_mass_assignment_of(:topic_id) }
    it { should allow_mass_assignment_of(:indices) }
  end

end
