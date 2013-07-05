require 'spec_helper'

describe HospitalsProcedure do

  it { should belong_to(:hospital) }
  it { should belong_to(:procedure) }
end
