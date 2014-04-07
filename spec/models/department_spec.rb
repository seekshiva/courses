require 'spec_helper'

describe Department do

  it "should have a factory" do
    expect(build :department).to be_valid
  end

  context "associations" do
    it { should belong_to(:hod).class_name('Faculty') }
    it { should have_many(:term_departments).dependent(:destroy) }
    it { should have_many(:terms).through(:term_departments) }
    it { should have_many(:courses).through(:term_departments) }
  end

  context "validations" do
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:short) }
    it { should allow_mass_assignment_of(:rollno_prefix) }
    it { should allow_mass_assignment_of(:hod_id) }
  end

end
