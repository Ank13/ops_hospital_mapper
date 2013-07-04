class CreateHospitals < ActiveRecord::Migration
	def change
		create_table :hospitals do |t|
			t.string :name
			t.integer :provider_id
			t.string :address
			t.string :city
			t.string :state
			t.string :hrr
			t.float :latitude
			t.float :longitude

			t.timestamps
		end
	end
end
