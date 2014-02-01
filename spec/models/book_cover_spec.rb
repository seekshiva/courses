require 'spec_helper'

describe BookCover do

  it { should have_one(:book) }

  it { should have_attached_file(:cover) }

  it { should allow_mass_assignment_of(:cover) }
  it { should allow_mass_assignment_of(:uploaded_by) }

end
