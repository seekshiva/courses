require 'spec_helper'

describe TopicDocument do

  it "should have a factory" do
    FactoryGirl.build(:topic_document).should be_valid
  end

  context "associations" do
    it { should belong_to(:document) }
    it { should belong_to(:topic) }
  end

  context "validations" do
    it { should allow_mass_assignment_of(:document_id) }
    it { should allow_mass_assignment_of(:topic_id) }
  end

end
