require 'spec_helper'

describe TermDepartment do

  context "associations" do
    it { should belong_to(:term) }
    it { should belong_to(:department) }
    it { should have_one(:course).through(:term) }
  end

  context "validations" do
    it { should allow_mass_assignment_of(:term_id) }
    it { should allow_mass_assignment_of(:department_id) }
    it { should validate_uniqueness_of(:term_id).scoped_to(:department_id) }
  end

end
