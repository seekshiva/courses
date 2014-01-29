require 'spec_helper'

describe TermFaculty do
  it "has unique {term, faculty}" do
    term = FactoryGirl.create(:term)
    faculty = FactoryGirl.create(:faculty)
    FactoryGirl.create(:term_faculty, term: term, faculty: faculty)
    expect {
      FactoryGirl.create(:term_faculty, term: term, faculty: faculty)
    }.to raise_exception
  end
end
