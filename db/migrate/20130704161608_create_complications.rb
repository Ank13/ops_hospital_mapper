class CreateComplications < ActiveRecord::Migration
	def change
		create_table :complications do |t|
			t.integer :provider_id

			t.timestamps
		end
	end	
end
