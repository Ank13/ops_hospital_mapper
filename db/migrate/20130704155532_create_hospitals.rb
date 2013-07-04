class CreateHospitals < ActiveRecord::Migration
	def change
		create_table :hospitals do |t|
			t.integer :provider_id
	    t.string  :provider_name
	    t.string  :provider_street_address
	    t.string  :provider_city
	    t.string  :provider_state
	    t.integer :provider_zip_code
	    t.string  :hrr
	    t.integer :total_discharges 
	    t.integer :count_drgs
	    t.float   :average_covered_charges 
			t.float	  :average_total_payments 
			t.float	  :latitude
			t.float	  :longitude

			t.timestamps
		end
	end
end
