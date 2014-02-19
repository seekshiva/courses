require 'spec_helper'

describe Book do

  context "associations" do
    it { should belong_to(:book_cover) }

    it { should have_many(:book_authors).dependent(:destroy) }
    it { should have_many(:authors).through(:book_authors) }
  end

  context "validations" do
    it { should allow_mass_assignment_of(:title) }
    it { should allow_mass_assignment_of(:publisher) }
    it { should allow_mass_assignment_of(:edition) }
    it { should allow_mass_assignment_of(:isbn) }
    it { should allow_mass_assignment_of(:year) }
    it { should allow_mass_assignment_of(:online_retail_url) }
    it { should allow_mass_assignment_of(:book_cover_id) }
    it { should allow_mass_assignment_of(:file_id) }
  end

  describe "#isbn_10" do
    it "should return valid isbn-10 value of the book" do
      book = FactoryGirl.create(:book)
      book.isbn_10.should eq Lisbn.new(book.isbn).isbn10
    end
  end

  describe "#isbn_13" do
    it "should return valid isbn-13 value of the book" do
      book = FactoryGirl.create(:book)
      book.isbn_13.should eq Lisbn.new(book.isbn).isbn13
    end
  end

end
