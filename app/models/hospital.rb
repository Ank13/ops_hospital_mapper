class Hospital < ActiveRecord::Base
  attr_accessible :provider_id, :provider_name, :provider_street_address, :provider_city, :provider_state, :provider_zip_code, :hrr, :total_discharges, :count_drgs, :average_covered_charges, :average_total_payments, :latitude, :longitude
  
  geocoded_by :full_address
  # after_validation :geocode 

  self.primary_key = "provider_id"
  has_many :hospitals_procedures, :foreign_key => 'provider_id'
  has_many :procedures, :through => :hospitals_procedures
  has_one  :patient_survey, :foreign_key => :provider_id, :primary_key => :provider_id
  has_one  :outcome, :foreign_key => :provider_id, :primary_key => :provider_id
  has_one  :complication, :foreign_key => :provider_id, :primary_key => :provider_id

  def full_address
    [provider_street_address, provider_city, provider_state, provider_zip_code].compact.join(', ')
  end

  def infobox_on_click(drg)
    unless hospitals_procedures.find_by_drg_id(drg).nil?
      hospital_charge = (hospitals_procedures.find_by_drg_id(drg).avg_covered_charges/1000)
    else
      hospital_charge = 0
    end
    state = self.provider_state

    procedure = Procedure.find_by_drg_id(drg)
    drg_def = procedure.drg_def

    state_charge = (StatesProcedure.where({"provider_state" => state, "drg_id" => procedure.drg_id }).first.avg_covered_charges)/1000
    natl_charge = (Procedure.find_by_drg_id(drg).natl_avg_total_payments/1000)
    {y_axis:'Cost',first_col: hospital_charge, second_col: state_charge, third_col: natl_charge, 
      state: state, hospital_id: provider_id, title: drg_def}
  end

  def complication_cost_correlation
        acc=[]
        rdstc =[]

        Hospital.all.each do |h|
          unless h.complication.nil?
            rdstc << h.complication.R_D_S_T_C
            acc << h.average_covered_charges
          end
        end

        R.acc = acc
        R.rdstc = rdstc

        R.eval 'costbenefit = cor(acc, rdstc)'
        costbenefit = R.pull 'costbenefit'
  end

  def outcomebox_on_click
    unless self.outcome.nil?
      p hosp_outcome_rate_p = self.outcome.mr_p.to_i
      p hosp_outcome_rate_h_a = self.outcome.mr_h_a.to_i
      p hosp_outcome_rate_hf = self.outcome.mr_hf.to_i
    else
      hospital_charge = 0
    end
    hosp_outcome_rate = hosp_outcome_rate_p + hosp_outcome_rate_h_a + hosp_outcome_rate_hf

    p avg_outcome_rate_p = Outcome.average("mr_p").to_i
    p avg_outcome_rate_h_a = Outcome.average("mr_h_a").to_i
    p avg_outcome_rate_hf = Outcome.average("mr_hf").to_i

    avg_outcome_rate = avg_outcome_rate_p + avg_outcome_rate_h_a + avg_outcome_rate_hf

    {y_axis:'Mortality',first_col: hosp_outcome_rate, second_col: avg_outcome_rate, third_col: 0, title: "30 Day Mortality from Heart Failure, Heart Attack or Pneumonia Admission"}
  end

  def complicationbox_on_click
    unless self.complication.R_D_S_T_C.nil?
      hosp_complication_rate = self.complication.R_D_S_T_C.to_i
    else
      hospital_charge = 0
    end
    avg_complication_rate = Complication.average("R_D_S_T_C").to_i
    
    {y_axis:'Mortality',first_col: hosp_complication_rate, second_col: avg_complication_rate, third_col: 0, title: '30 Day Mortality from Serious Treatable Complications (per 1000 admissions)'}
  end

  def self.find_hospitals_for_map(hospitals)
    all_hospitals = []
    hospitals.each do |hospital|
      acc = hospital.average_covered_charges/1600
      unless hospital.patient_survey.nil? || hospital.outcome.nil? || hospital.outcome.mr_h_a.nil? || hospital.outcome.mr_hf.nil? || hospital.outcome.mr_p.nil?
        thumbs_up = (hospital.patient_survey.recommend_y + hospital.patient_survey.recommend_ok)*40 
        thumbs_down = hospital.patient_survey.recommend_no*50
        mortality = (hospital.outcome.mr_h_a + hospital.outcome.mr_hf + hospital.outcome.mr_p)/2
        all_hospitals << {provider_name: hospital.provider_name, latitude: hospital.latitude, longitude: hospital.longitude, 
        provider_id: hospital.provider_id, infobox_html: hospital.infobox_html_on_load, acc: acc, thumbs_up: thumbs_up, 
        thumbs_down: thumbs_down, mortality: mortality}
      else
        all_hospitals << {provider_name: hospital.provider_name, latitude: hospital.latitude, longitude: hospital.longitude, 
        provider_id: hospital.provider_id, infobox_html: hospital.infobox_html_on_load, acc: acc}
      end
    end
    return all_hospitals  
  end

  def infobox_html_on_load
    unless (self.patient_survey.nil? || self.outcome.nil? || self.patient_survey.recommend_y.nil? || self.patient_survey.survey_response_rate.nil? || self.outcome.readm_ha.nil? || self.total_discharges.nil? || self.average_covered_charges.nil? || self.average_total_payments.nil?)
      return "
              <div class='wrapper'>
              <span class='inbox-tab'><a class='info-comparison' id='#{provider_id}' href='#'>Procedure Cost Comparison</a></span>
              <span class='inbox-tab'><a class='info-outcomes' id='#{provider_id}' href='#'>Outcomes</a></span>
              <span class='inbox-tab'><a class='info-complications' id='#{provider_id}' href='#'>Complications</a></span>
              
              </div>
              <div id='description'>
              <div class='info-box'> #{provider_name} </div>
              <ul>
                <li> #{(patient_survey.recommend_y * 100).round(0)}% of patients recommend this hospital
                <span class='note'>(#{(patient_survey.survey_response_rate * 100).round(0)}% response rate)</span></li>
                <li> Readmission rate from heart attack: #{outcome.readm_ha }</li>
                <li> Reported discharges (CMS): #{total_discharges}</li>
                <li> Average Covered Charges (all procedures, CMS): $#{(average_covered_charges/1000).round(0)}K</li>
                <li> Average Total Payment (all procedures, CMS): $#{(average_total_payments/1000).round(0)}K</li>
              </ul></div>"
    else
      return "<div class='info-box'> #{provider_name} </div>
              <ul>
                <li> Average Covered Charges (all procedures, CMS): $#{(average_covered_charges/1000).round(0)}K</li>
                <li> Average Total Payment (all procedures), CMS: $#{(average_total_payments/1000).round(0)}K</li>
              </ul>"
    end
  end
end



  

