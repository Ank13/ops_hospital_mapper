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
			@hospital.outcome = FactoryGirl.create(:outcome)
			@procedure = FactoryGirl.create(:procedure)
			@states_procedure = FactoryGirl.create(:states_procedure)
		end

		it 'should concat address' do
			@hospital.full_address.should eq "1234 Mercy Way, Chicago, IL, 60669"
		end

		it 'should return correct hospital complication rate json' do
			@hospital.complicationbox_on_click.should eq({y_axis: 'Mortality', first_col: 10, second_col: 10, third_col: 0, title: '30 Day Mortality from Serious Treatable Complications (per 1000 admissions)'})
		end

		it 'should return correct ' do
			@hospital.outcomebox_on_click.should eq({y_axis: 'Mortality', first_col: 50, second_col: 50, third_col: 0, title: "30 Day Mortality from Heart Failure, Heart Attack or Pneumonia Admission"})
		end


		it 'should return correct scaled total cost index' do
			@hospital.scaled_total_cost_index.should eq(24)
		end

	end
end
 
 #      state: state, hospital_id: provider_id, title: drg_def}