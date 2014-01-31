require 'spec_helper'

describe Document do
  
  it { should allow_mass_assignment_of(:document) }
  it { should allow_mass_assignment_of(:uploaded_by) } 

end