class CreateStatesProcedures < ActiveRecord::Migration
	def change
		create_table :states_procedures do |t|
      t.integer  :drg_id
      t.string   :provider_state
      t.integer  :total_discharges
      t.float    :avg_covered_charges
      t.float    :avg_total_payments
			
			t.timestamps
		end
	end
end
