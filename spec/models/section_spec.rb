require 'spec_helper'

describe Section do
  it { should belong_to(:term) }
  it { should have_many(:topics) }

  it { should allow_mass_assignment_of(:term_id) }
  it { should allow_mass_assignment_of(:title) }

  it { should validate_uniqueness_of(:term_id).scoped_to(:title) }
end
