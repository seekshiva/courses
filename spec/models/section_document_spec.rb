require 'spec_helper'

describe SectionDocument do

  it "should have a factory" do
    expect(build :section_document).to be_valid
  end

  context "associations" do
    it { should belong_to(:section) }
    it { should belong_to(:document) }
  end

  context "validations" do
    it { should allow_mass_assignment_of(:section_id) }
    it { should allow_mass_assignment_of(:document_id) }
    it { should validate_uniqueness_of(:section_id).scoped_to(:document_id) }
  end
end
