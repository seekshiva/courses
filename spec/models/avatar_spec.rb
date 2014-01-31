require 'spec_helper'

describe Avatar do

  it { should have_one(:user) }

  it { should have_attached_file(:pic) }

  it { should allow_mass_assignment_of(:pic) }

  describe ".file_dimension" do
    pending
  end
end
