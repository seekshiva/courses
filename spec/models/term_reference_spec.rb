require 'spec_helper'

describe TermReference do
  it { should belong_to(:term) }
  it { should belong_to(:book) }

  it { should have_many(:references) }
  it { should have_many(:topics).through(:references) }

  it { should allow_mass_assignment_of(:book_id) }
  it { should allow_mass_assignment_of(:term_id) }

  it { should validate_uniqueness_of(:book_id).scoped_to(:term_id) }
end
