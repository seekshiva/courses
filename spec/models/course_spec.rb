require 'spec_helper'

describe Course do

  it "should have a factory" do
    expect(build :course).to be_valid
  end

  context "associations" do
    it { should have_many(:terms).dependent(:destroy) }
    it { should have_many(:subscriptions).through(:terms) }
    it { should have_many(:users).through(:subscriptions) }
    it { should have_many(:term_departments).through(:terms) }
    it { should have_many(:departments).through(:term_departments) }
    it { should have_many(:term_faculties).through(:terms) }
    it { should have_many(:faculties).through(:term_faculties) }
    it { should have_many(:term_references).through(:terms) }
    it { should have_many(:books).through(:term_references) }
    it { should have_many(:sections).through(:terms) }
    it { should have_many(:topics).through(:sections) }
  end

  context "validations" do
    it { should allow_mass_assignment_of(:subject_code) }
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:credits) }
    it { should allow_mass_assignment_of(:about) }
    it { should validate_presence_of(:subject_code).with_message("-> not present") }
    it { should validate_presence_of(:name).with_message("-> not present") }
    it { should validate_uniqueness_of(:subject_code) }
    it { should validate_numericality_of(:credits).is_greater_than_or_equal_to(0) } # zero credit courses can exist
  end

  describe "#current_term" do
    pending
  end

  describe "#this_year" do
    pending
  end

  describe "#latest_term" do
    pending
  end

  describe "#as_json" do
    pending
  end

end
