class Procedure < ActiveRecord::Base
<<<<<<< HEAD
  attr_accessible :drg_id, :drg_def, :total_discharges, :avg_covered_charges, :avg_total_payments, :natl_total_discharges, :natl_avg_covered_charges, :natl_avg_total_payments, :description, :clinical_category
=======

  include StatsHelper


  attr_accessible :drg_id, :drg_def, :total_discharges_IL, :avg_covered_charges_IL, :avg_total_payments_IL, :natl_total_discharges, :natl_avg_covered_charges, :natl_avg_total_payments, :description, :clinical_category
>>>>>>> 9584158d47a5c1648e8e07bba450a3733dfc9c04

	self.primary_key = "drg_id"
  has_many :hospitals_procedures, :foreign_key => :drg_id
	has_many :hospitals, :through => :hospitals_procedures, :primary_key => :drg_id
  has_many :states_procedures, :foreign_key => :drg_id


  def most_expensive_hospital
    hospitals_procedures.order('avg_covered_charges DESC').limit(1).first
  end

  def least_expensive_hospital
    hospitals_procedures.order('avg_covered_charges ASC').limit(1).first
  end

  def average_cost
    hospitals_procedures.average('avg_covered_charges').to_i
  end

  def stand_dev
    allhosp = []
    hospitals_procedures.all.each{|hp| allhosp << hp.avg_covered_charges}
    allhosp.standard_deviation
  end

end


