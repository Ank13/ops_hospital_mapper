module InfoboxHelper

  # def infobox_html_on_load(hospital)
  #   unless (hospital.patient_survey.nil? || hospital.outcome.nil? || hospital.patient_survey.recommend_y.nil? || hospital.patient_survey.survey_response_rate.nil? || hospital.outcome.readm_ha.nil? || hospital.total_discharges.nil? || hospital.average_covered_charges.nil? || hospital.average_total_payments.nil?)
  #     return "
  #             <div class='wrapper'>
  #             <span class='inbox-tab'><a class='info-comparison' id='#{provider_id}' href='#'>Procedure Cost Comparison</a></span>
  #             <span class='inbox-tab'><a class='info-outcomes' id='#{provider_id}' href='#'>Outcomes</a></span>
  #             <span class='inbox-tab'><a class='info-complications' id='#{provider_id}' href='#'>Complications</a></span>
              
  #             </div>
  #             <div id='description'>
  #             <div class='info-box'> #{provider_name} </div>
  #             <ul>
  #               <li> #{(patient_survey.recommend_y * 100).round(0)}% of patients recommend this hospital
  #               <span class='note'>(#{(patient_survey.survey_response_rate * 100).round(0)}% response rate)</span></li>
  #               <li> Readmission rate from heart attack: #{outcome.readm_ha }</li>
  #               <li> Reported discharges (CMS): #{total_discharges}</li>
  #               <li> Average Covered Charges (all procedures, CMS): $#{(average_covered_charges/1000).round(0)}K</li>
  #               <li> Average Total Payment (all procedures, CMS): $#{(average_total_payments/1000).round(0)}K</li>
  #             </ul></div>"
  #   else
  #     return "<div class='info-box'> #{provider_name} </div>
  #             <ul>
  #               <li> Average Covered Charges (all procedures, CMS): $#{(average_covered_charges/1000).round(0)}K</li>
  #               <li> Average Total Payment (all procedures), CMS: $#{(average_total_payments/1000).round(0)}K</li>
  #             </ul>"
  #   end
  # end

end
