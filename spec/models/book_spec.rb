require 'spec_helper'

describe Book do
  
  it { should belong_to(:book_cover) }
  
  it { should have_many(:book_authors).dependent(:destroy) }
  it { should have_many(:authors).through(:book_authors) }

  it { should allow_mass_assignment_of(:title) }
  it { should allow_mass_assignment_of(:publisher) }
  it { should allow_mass_assignment_of(:edition) }
  it { should allow_mass_assignment_of(:isbn) }
  it { should allow_mass_assignment_of(:year) }
  it { should allow_mass_assignment_of(:online_retail_url) }
  it { should allow_mass_assignment_of(:book_cover_id) }
  it { should allow_mass_assignment_of(:file_id) }

end
