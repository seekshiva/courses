require 'spec_helper'

describe TermReference do
  it "should have unique {book, term}" do
    book = FactoryGirl.create(:book)
    term = FactoryGirl.create(:term)

    FactoryGirl.create(:term_reference, book: book, term: term)
    expect {
      FactoryGirl.create(:term_reference, book: book, term: term)
    }.to raise_exception
  end
end
