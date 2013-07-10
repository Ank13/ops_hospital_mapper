class CreateComplications < ActiveRecord::Migration
	def change
		create_table :complications do |t|
			t.integer :provider_id
      t.integer :N_P_D_S_T_C
      t.float   :R_D_S_T_C
      t.float   :L_E_D_S_T_C
      t.float   :H_E_D_S_T_C
      t.integer :N_P_C_L
      t.float   :R_C_L
      t.float   :L_E_C_L
      t.float   :H_E_C_L
      t.integer :N_P_B_C
      t.float   :R_B_C

			t.timestamps
		end
	end	
end
