class CreateOutcomes < ActiveRecord::Migration
	def change
		create_table :outcomes do |t|
			t.integer :provider_id

			t.timestamps
		end
	end
end

