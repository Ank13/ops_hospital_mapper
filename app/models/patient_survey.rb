class PatientSurvey < ActiveRecord::Base
  attr_accessible :provider_id, :doc_comm_bad, :doc_com_ok, :doc_com_good,
                  :help_timingbad, :help_timing_ok, :help_timing_good,
                  :pain_ctrl_bad, :pain_ctrl_ok, :pain_ctrl_good, :quiet_no,
                  :quiet_usu, :quiet_always, :recovery_info_yes, :recovery_info_no,
                  :rating_low, :rating_mid, :rating_high, :recommend_no, :recommend_ok,
                  :recommend_y, :num_surveys, :survey_response_rate

	belongs_to :hospital, :foreign_key => :provider_id
end
