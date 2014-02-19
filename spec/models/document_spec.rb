require 'spec_helper'

describe Document do

  context "associations" do
    it { should belong_to(:user).with_foreign_key("uploaded_by")}
    it { should have_many(:topic_documents).dependent(:destroy)}
    it { should have_many(:topics).through(:topic_documents)}
    it { should have_one(:term_document).dependent(:destroy)}
    it { should have_one(:term).through(:term_document)}
    it { should have_attached_file(:document) }
  end

  context "validations" do
    it { should allow_mass_assignment_of(:document) }
    it { should allow_mass_assignment_of(:uploaded_by) }
  end

end
