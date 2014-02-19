require 'spec_helper'

describe Section do

  context "associations" do
    it { should belong_to(:term) }
    it { should have_many(:topics).dependent(:destroy) }
  end

  context "validations" do
    it { should allow_mass_assignment_of(:term_id) }
    it { should allow_mass_assignment_of(:title) }
    it { should validate_uniqueness_of(:term_id).scoped_to(:title) }
  end

end
