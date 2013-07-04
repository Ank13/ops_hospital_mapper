class Hospital < ActiveRecord::Base
  has_many :hospitals_procedures
  has_many :procedures, :through => :hospitals_procedures
  has_one  :patient_survey
  has_one  :outcome
  has_one  :complication
end