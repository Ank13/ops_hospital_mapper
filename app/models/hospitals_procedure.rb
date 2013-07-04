class HospitalsProcedure < ActiveRecord::Base
  belongs_to :hospital,  :foreign_key => 'provider_id'
  belongs_to :procedure, :foreign_key => 'drg_id'
end
