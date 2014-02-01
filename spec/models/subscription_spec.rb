require 'spec_helper'

describe Subscription do

  it { should belong_to(:user) }
  it { should belong_to(:term) }

  it { should allow_mass_assignment_of(:attending) }
  it { should allow_mass_assignment_of(:term_id) }
  it { should allow_mass_assignment_of(:user_id) }

  it { should validate_uniqueness_of(:term_id).scoped_to(:user_id) }
end
