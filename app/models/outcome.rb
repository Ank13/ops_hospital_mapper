class Outcome < ActiveRecord::Base
  attr_accessible :provider_id,:mr_h_a,:lme_mr_h_a,:ume_mr_h_a,
                  :num_p_mr_ha,:mr_hf,:lme_mr_hf,:ume_mr_hf,:num_p_mr_hf,
                  :mr_p,:lme_mr_pn,:ume_mr_pn,:num_p_mr_pn,:readm_ha,:lreadma_ha,
                  :ureadma_ha,:num_p_readm_ha,:readma_hf,:lreadmae_hf,:ureadmae_hf,
                  :num_p_readma_hf,:readma_pn,:lreadma_pn,:ureadma_pn,:num_p_readma_pn

	belongs_to :hospital, :foreign_key => :provider_id
end
