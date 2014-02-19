require 'spec_helper'

describe TermDocument do

  context "associations" do
    it { should belong_to(:term) }
    it { should belong_to(:document) }
  end

  context "validations" do
    it { should allow_mass_assignment_of(:term_id) }
    it { should allow_mass_assignment_of(:document_id) }
    it { should validate_uniqueness_of(:term_id).scoped_to(:document_id) }
  end

end
