class Procedure < ActiveRecord::Base
  attr_accessible :drg_id, :drg_def, :total_discharges, :avg_covered_charges, :avg_total_payments, :natl_total_discharges, :natl_avg_covered_charges, :natl_avg_total_payments, :description, :clinical_category

	# self.primary_key = "drg_id"
  has_many :hospitals_procedures, :foreign_key => :drg_id
	has_many :hospitals, :through => :hospitals_procedures, :primary_key => :drg_id
  has_many :states_procedures, :foreign_key => :drg_id

end


