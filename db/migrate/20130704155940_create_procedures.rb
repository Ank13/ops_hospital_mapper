class CreateProcedures < ActiveRecord::Migration
	def change
		create_table :procedures, :id => false do |t|
      t.integer  :drg_id
      t.string   :drg_def
      t.integer  :total_discharges_IL
      t.float    :avg_covered_charges_IL
      t.float    :avg_total_payments_IL
      t.integer  :natl_total_discharges
      t.float    :natl_avg_covered_charges
      t.float    :natl_avg_total_payments
			
			t.timestamps
		end
	end
end
