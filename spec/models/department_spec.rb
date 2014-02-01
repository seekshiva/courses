require 'spec_helper'

describe Department do
  it { should belong_to(:hod).class_name('Faculty') }

  it { should have_many(:term_departments).dependent(:destroy) }
  it { should have_many(:terms).through(:term_departments) }
  it { should have_many(:courses).through(:term_departments) }

  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:short) }
  it { should allow_mass_assignment_of(:rollno_prefix) }
  it { should allow_mass_assignment_of(:hod_id) }
end
