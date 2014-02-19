require 'spec_helper'

describe Author do

  context "associations" do
    it { should have_many(:book_authors).dependent(:destroy) }
    it { should have_many(:books).through(:book_authors) }
  end

  context "validations" do
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:about) }
    it { should validate_presence_of(:name).with_message("-> not present") }
    it { should validate_uniqueness_of(:name) }
  end

end
