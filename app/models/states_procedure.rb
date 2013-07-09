class StatesProcedure < ActiveRecord::Base
  attr_accessible :drg_id, :provider_state, :total_discharges, :avg_covered_charges, :avg_total_payments

  belongs_to :procedure, :foreign_key => :drg_id

end

