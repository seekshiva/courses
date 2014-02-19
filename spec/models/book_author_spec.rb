require 'spec_helper'

describe BookAuthor do

  context "associations" do
    it { should belong_to(:book) }
    it { should belong_to(:author) }
  end

  context "validations" do
    it { should allow_mass_assignment_of(:book_id) }
    it { should allow_mass_assignment_of(:author_id) }
    it { should validate_uniqueness_of(:book_id).scoped_to(:author_id) }
  end

end
