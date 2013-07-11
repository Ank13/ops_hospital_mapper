FactoryGirl.define do 

	factory :patient_survey do
		provider_id						1
		doc_comm_bad					12.23
		doc_com_ok						40.20
		doc_com_good					47.57
		help_timingbad				12.23
		help_timing_ok				40.20
		help_timing_good			47.57
		pain_ctrl_bad					12.23
		pain_ctrl_ok					40.20
		pain_ctrl_good				47.57
		quiet_no							12.23
		quiet_usu							40.20
		quiet_always					47.57
		recover_info_yes			50.00
		recover_info_no				50.00
		rating_low						12.23
		rating_mid						40.20
		rating_high						47.57
		recommend_no					12.23
		recommend_ok					40.20
		recommend_y						47.57
		num_surveys						"2000"
		survey_response_rate	12.00
	end
	
end