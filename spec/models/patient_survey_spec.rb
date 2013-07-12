require 'spec_helper'

describe PatientSurvey do

	it { should be_instance_of(PatientSurvey) }
	
  it { should belong_to(:hospital) }
end
