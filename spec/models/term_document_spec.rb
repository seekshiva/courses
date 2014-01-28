require 'spec_helper'

describe TermDocument do
  it "has unique {term, document}" do
    term = FactoryGirl.create(:term)
    document = FactoryGirl.build(:document)
    FactoryGirl.create(:term_document, term: term, document: document)
    expect {
      FactoryGirl.create(:term_document, term: term, document: document)
    }.to raise_exception
  end
end
