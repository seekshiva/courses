require 'spec_helper'

describe Avatar do

  it { should have_one(:user) }

  describe ".file_dimension" do
    pending
  end
end
