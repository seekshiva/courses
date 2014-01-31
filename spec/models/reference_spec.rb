require 'spec_helper'

describe Reference do

  it { should belong_to(:term_reference) }
  it { should belong_to(:topic) }

  it { should have_one(:book).through(:term_reference) }

  it { should allow_mass_assignment_of(:term_reference_id) }
  it { should allow_mass_assignment_of(:topic_id) }
  it { should allow_mass_assignment_of(:indices) }

end