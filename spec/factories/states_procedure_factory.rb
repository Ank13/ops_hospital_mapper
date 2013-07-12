FactoryGirl.define do

	factory :states_procedure do
		drg_id							1
		provider_state			"IL"
		total_discharges		2000
		avg_covered_charges 123.45
		avg_total_payments	12.34
	end

end