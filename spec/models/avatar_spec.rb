require 'spec_helper'

describe Avatar do

  context "associations" do
    it { should have_one(:user) }
    it { should have_attached_file(:pic) }
  end

  context "validations" do
    it { should allow_mass_assignment_of(:pic) }
  end

  describe ".file_dimension" do
    pending
  end
end
