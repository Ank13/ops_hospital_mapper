class CreateHospitalsProcedures < ActiveRecord::Migration
	def change 
	  create_table :hospitals_procedures do |t|
      t.integer  :drg_id
      t.string   :drg_def 
      t.integer  :provider_id
      t.string   :provider_name
      t.integer  :total_discharges
      t.float    :avg_covered_charges
      t.float    :avg_total_payments
		end
	end
end
