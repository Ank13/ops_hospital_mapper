class Complication < ActiveRecord::Base
	attr_accessible :provider_id, :N_P_D_S_T_C, :R_D_S_T_C, :L_E_D_S_T_C, :H_E_D_S_T_C, :N_P_C_L, :R_C_L, :L_E_C_L, :H_E_C_L, :N_P_B_C, :R_B_C

  belongs_to :hospital, :foreign_key => :provider_id
end
