require 'spec_helper'

describe Hospital do

	before(:each) do
		@count = Hospital.all.count
	end

	it { should have_many(:hospitals_procedures) }
	it { should have_many(:procedures) }
	it { should have_one(:outcome) }
	it { should have_one(:patient_survey) }
	it { should have_one(:complication) }

end