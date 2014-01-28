require 'spec_helper'

describe Section do
  it "should have unique {term, title}" do
    term = FactoryGirl.create(:term)
    title = "SectionTitle"
    FactoryGirl.create(:section, term: term, title: title)
    expect {
      FactoryGirl.create(:section, term: term, title: title)
    }.to raise_exception
  end
end
