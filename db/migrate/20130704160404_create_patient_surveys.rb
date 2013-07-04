class CreatePatientSurveys < ActiveRecord::Migration
	def change
		create_table :patient_surveys do |t|
			t.integer :provider_id

			t.timestamps
		end
	end
end

