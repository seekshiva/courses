require 'spec_helper'

describe TermFaculty do

  context "associations" do
    it { should belong_to(:term) }
    it { should belong_to(:faculty) }
  end

  context "validations" do
    it { should allow_mass_assignment_of(:term_id) }
    it { should allow_mass_assignment_of(:faculty_id) }
    it { should allow_mass_assignment_of(:faculty_email) }
    it { should validate_uniqueness_of(:term_id).scoped_to(:faculty_id) }
  end

end
