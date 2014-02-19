require 'spec_helper'

describe SectionDocument do

  context "validations" do
    it { should allow_mass_assignment_of(:section_id) }
    it { should allow_mass_assignment_of(:document_id) }
    it { should validate_uniqueness_of(:section_id).scoped_to(:document_id) }
  end
end
