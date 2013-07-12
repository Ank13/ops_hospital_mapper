require 'spec_helper'

describe HospitalsProcedure do

	it { should be_instance_of(HospitalsProcedure) }

  it { should belong_to(:hospital) }
  it { should belong_to(:procedure) }
end
