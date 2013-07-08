class Procedure < ActiveRecord::Base
  attr_accessible :drg_id, :drg_def, :total_discharges_IL, :avg_covered_charges_IL, :avg_total_payments_IL, :natl_total_discharges, :natl_avg_covered_charges, :natl_avg_total_payments

	set_primary_key"drg_id"
  has_many :hospitals_procedures, :foreign_key => :drg_id
	has_many :hospitals, :through => :hospitals_procedures, :primary_key => :drg_id
end
# dont leave random whitespace and newlines