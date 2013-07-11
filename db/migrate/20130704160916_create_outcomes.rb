class CreateOutcomes < ActiveRecord::Migration
	def change
		create_table :outcomes do |t|
			t.integer :provider_id
      t.float   :mr_h_a
      t.float   :lme_mr_h_a
      t.float   :ume_mr_h_a
      t.integer :num_p_mr_ha
      t.float   :mr_hf
      t.float   :lme_mr_hf
      t.float   :ume_mr_hf
      t.integer :num_p_mr_hf
      t.float   :mr_p
      t.float   :lme_mr_pn
      t.float   :ume_mr_pn
      t.integer :num_p_mr_pn
      t.float   :readm_ha
      t.float   :lreadma_ha
      t.float   :ureadma_ha
      t.integer :num_p_readm_ha
      t.float   :readma_hf
      t.float   :lreadmae_hf
      t.float   :ureadmae_hf
      t.integer :num_p_readma_hf
      t.float   :readma_pn
      t.float   :lreadma_pn
      t.float   :ureadma_pn
      t.integer :num_p_readma_pn

			t.timestamps
		end
	end
end

