require 'spec_helper'

describe Term do
  it { should belong_to(:course) }

  it { should have_many(:sections).dependent(:destroy) }
  it { should have_many(:topics).through(:sections).dependent(:destroy) }

  it { should have_many(:term_departments).dependent(:destroy) }
  it { should have_many(:departments).through(:term_departments) }

  it { should have_many(:term_faculties).dependent(:destroy) }
  it { should have_many(:faculties).through(:term_faculties) }

  it { should have_many(:term_references).dependent(:destroy) }
  it { should have_many(:books).through(:term_references) }

  it { should have_many(:subscriptions).dependent(:destroy) }
  it { should have_many(:users).through(:subscriptions) }

  it { should have_many(:term_documents).dependent(:destroy) }
  it { should have_many(:documents).through(:term_documents) }
    
  it { should allow_mass_assignment_of(:course_id) }
  it { should allow_mass_assignment_of(:academic_year) }
  it { should allow_mass_assignment_of(:semester) }

  describe ".year" do
    pending
  end

  describe ".is_current?" do
    pending
  end

  describe ".this_year?" do
    pending
  end

  describe ".is_odd_term?" do
    pending
  end
end
