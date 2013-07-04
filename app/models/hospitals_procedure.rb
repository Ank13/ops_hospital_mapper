class HospitalsProcedure < ActiveRecord::Base
  attr_accessible :drg_id, :drg_def, :provider_id, :provider_name, :total_discharges, :avg_covered_charges, :avg_total_payments

  belongs_to :hospital
  belongs_to :procedure
end
