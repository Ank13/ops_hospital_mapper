FactoryGirl.define do

	factory :hospital do
		provider_id 						 1
		provider_name						 'Mercy Hospital'
		provider_street_address  '1234 Mercy Way'
		provider_city            'Chicago'
		provider_state   				 'IL'
		provider_zip_code  			 60669
		hrr  										 'Chicagoland'
		total_discharges 				 100
		count_drgs 							 50
		average_covered_charges  1200.20
		average_total_payments   120.20
		latitude 								 83.2123
		longitude 							 21.2432
		total_cost_index				 20
	end
	
end
