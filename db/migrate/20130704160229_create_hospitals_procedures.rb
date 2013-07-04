class CreateHospitalsProcedures < ActiveRecord::Migration
	def change 
		create_table :hospitals_procedures do |t|
			t.integer :hospital_id
			t.integer :procedure_id
		end
	end
end
