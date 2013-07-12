FactoryGirl.define do

	factory :procedure do
		drg_id											1 
		drg_def											"hip replacement"
		total_discharges 						200
		avg_covered_charges 				123.45
		avg_total_payments 					12.34
		natl_total_discharges				2000
		natl_avg_covered_charges 		234.56
		natl_avg_total_payments 		23.45
		description									"1 - hip replacement"
		clinical_category						"hip"
	end
		
end