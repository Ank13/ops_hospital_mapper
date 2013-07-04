class CreateProcedures < ActiveRecord::Migration
	def change
		create_table :procedures do |t|
			
			t.timestamps
		end
	end
end
