FactoryGirl.define do

	factory :hospitals_procedure do
		drg_id 							1
		drg_def							"hip replacement"
		provider_id					1
		provider_name 			'Mercy Hospital'
		total_discharges		200
		avg_covered_charges 123.45
		avg_total_payments   12.34
		cost_index					20
	end

end