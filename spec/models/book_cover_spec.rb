require 'spec_helper'

describe BookCover do

  xit "should have a factory" do
    expect(build :book_cover).to be_valid
  end

  context "associations" do
    it { should have_one(:book) }
    it { should have_attached_file(:cover) }
  end

  context "validations" do
    it { should allow_mass_assignment_of(:cover) }
    it { should allow_mass_assignment_of(:uploaded_by) }
  end

end
