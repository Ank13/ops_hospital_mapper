require 'spec_helper'

describe Hospital do

  it { should be_instance_of(Hospital) }

	it { should have_many(:hospitals_procedures) }
	it { should have_many(:procedures) }
	it { should have_one(:outcome) }
	it { should have_one(:patient_survey) }
	it { should have_one(:complication) }

	context 'public methods' do
		before(:each) do
			@hospital = FactoryGirl.create(:hospital)
			@hospital.complication = FactoryGirl.create(:complication)
			@hospital.hospitals_procedures = FactoryGirl.create(:hospitals_procedure)
			@procedure = FactoryGirl.create(:procedure)
			@states_procedure = FactoryGirl.create(:states_procedure)
		end

		it 'should concat address' do
			@hospital.full_address.should eq "1234 Mercy Way, Chicago, IL, 60669"
		end

		it 'should output correct json data when infobox is clicked' do
			@hospital.infobox_on_click(1).should eq {y_axis:'Cost', first_col: 0.12345, second_col: 0.12345, third_col: 0.02345, state: 'IL', hospital_id: 1, title: "hip replacement"}
		end

		it 'should return correct hospital complication rate' do
			@hospital.complicationbox_on_click.should eq({y_axis: 'Mortality', first_col: 10, second_col: 10, third_col: 0, title: '30 Day Mortality from Serious Treatable Complications (per 1000 admissions)'})
		end

		it 'should return correct scaled total cost index' do
			@hospital.scaled_total_cost_index.should eq(24)
		end

	end
end
 # {y_axis:'Cost', first_col: hospital_charge, second_col: state_charge, third_col: natl_charge, 
 #      state: state, hospital_id: provider_id, title: drg_def}