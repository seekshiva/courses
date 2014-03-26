require 'spec_helper'

describe Topic do

  it "should have a factory" do
    FactoryGirl.build(:topic).should be_valid
  end

  context "associations" do
    it { should belong_to(:section) }
    it { should have_many(:references).dependent(:destroy) }
    it { should have_many(:term_references).through(:references) }
    it { should have_many(:books).through(:term_references) }
    it { should have_many(:notes).with_foreign_key("topic_id").class_name("TopicDocument").dependent(:destroy) }
    it { should have_many(:documents).through(:notes) }
    it { should have_many(:class_topics).dependent(:destroy) }
    it { should have_many(:classrooms).through(:class_topics) }
  end
  
  context "validations" do
    it { should allow_mass_assignment_of(:title) }
    it { should allow_mass_assignment_of(:description) }
    it { should allow_mass_assignment_of(:ct_status) }
    it { should allow_mass_assignment_of(:section_id) }
  end

end
