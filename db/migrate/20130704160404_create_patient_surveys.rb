class CreatePatientSurveys < ActiveRecord::Migration
	def change
    create_table :patient_surveys do |t|
      t.integer :provider_id
      t.float   :doc_comm_bad
      t.float   :doc_com_ok
      t.float   :doc_com_good
      t.float   :help_timingbad
      t.float   :help_timing_ok
      t.float   :help_timing_good
      t.float   :pain_ctrl_bad
      t.float   :pain_ctrl_ok
      t.float   :pain_ctrl_good
      t.float   :quiet_no
      t.float   :quiet_usu
      t.float   :quiet_always
      t.float   :recovery_info_yes
      t.float   :recovery_info_no
      t.float   :rating_low
      t.float   :rating_mid
      t.float   :rating_high
      t.float   :recommend_no
      t.float   :recommend_ok
      t.float   :recommend_y
      t.string  :num_surveys
      t.float   :survey_response_rate

    	t.timestamps
		end
	end
end

