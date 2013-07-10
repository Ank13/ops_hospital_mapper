class CreateProcedures < ActiveRecord::Migration
		def change
			create_table :procedures do |t|
	      t.integer  :drg_id
	      t.string   :drg_def
	      t.integer  :total_discharges
	      t.float    :avg_covered_charges
	      t.float    :avg_total_payments
	      t.integer  :natl_total_discharges
	      t.float    :natl_avg_covered_charges
	      t.float    :natl_avg_total_payments
				
				t.timestamps
			end
		end
	end
