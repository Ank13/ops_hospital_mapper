require 'spec_helper'

describe Hospital do

	it { should have_many(:hospitals_procedures) }
	it { should have_many(:procedures) }
	it { should have_one(:outcome) }
	it { should have_one(:patient_survey) }
	it { should have_one(:complication) }
  it { should validate_presence_of(:provider_id)}

end
