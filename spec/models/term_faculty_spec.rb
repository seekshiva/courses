require 'spec_helper'

describe TermFaculty do

  it { should belong_to(:term) }
  it { should belong_to(:faculty) }

  it { should allow_mass_assignment_of(:term_id) }
  it { should allow_mass_assignment_of(:faculty_id) }
  it { should allow_mass_assignment_of(:faculty_email) }


  it "has unique {term, faculty}" do
    term = FactoryGirl.create(:term)
    faculty = FactoryGirl.create(:faculty)
    FactoryGirl.create(:term_faculty, term: term, faculty: faculty)
    expect {
      FactoryGirl.create(:term_faculty, term: term, faculty: faculty)
    }.to raise_exception
  end
end
