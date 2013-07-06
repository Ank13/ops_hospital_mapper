class Hospital < ActiveRecord::Base
  attr_accessible :provider_id, :provider_name, :provider_street_address, :provider_city, :provider_state, :provider_zip_code, :hrr, :total_discharges, :count_drgs, :average_covered_charges, :average_total_payments, :latitude, :longitude
  
  geocoded_by :full_address
  # after_validation :geocode 

  set_primary_key"provider_id"
  has_many :hospitals_procedures, :foreign_key => 'provider_id'
  has_many :procedures, :through => :hospitals_procedures
  has_one  :patient_survey, :foreign_key => :provider_id, :primary_key => :provider_id
  has_one  :outcome, :foreign_key => :provider_id, :primary_key => :provider_id
  has_one  :complication, :foreign_key => :provider_id, :primary_key => :provider_id

  def full_address
    [provider_street_address, provider_city, provider_state, provider_zip_code].compact.join(', ')
  end

  def infobox_html_on_load
    unless self.patient_survey.nil? && self.outcome.nil?
      return "<div class='info-box'> #{provider_name} </div>
              <p><a class='info-click' id='#{provider_id}' href='#'>Comparison Details</a></p>
              <ul>
                <li> #{(patient_survey.recommend_y * 100).round(0)}% of patients recommend this hospital
                <span class='note'>(#{(patient_survey.survey_response_rate * 100).round(0)}% response rate)</span></li>
                <li> Readmission rate from heart attack: #{outcome.readm_ha }</li>
                <li> Reported discharges (CMS): #{total_discharges}</li>
                <li> Average Covered Charges (all procedures, CMS): $#{(average_covered_charges/1000).round(0)}K</li>
                <li> Average Total Payment (all procedures, CMS): $#{(average_total_payments/1000).round(0)}K</li>
              </ul>"
    else
      return "<div class='info-box'> #{provider_name} </div>
              <ul>
                <li> Average Covered Charges (all procedures, CMS): $#{(average_covered_charges/1000).round(0)}K</li>
                <li> Average Total Payment (all procedures), CMS: $#{(average_total_payments/1000).round(0)}K</li>
              </ul>"
    end
  end

  def infobox_on_click
    unless hospitals_procedures.find_by_drg_id(39).nil?
      hospital_charge = (hospitals_procedures.find_by_drg_id(39).avg_covered_charges/1000)
    else
      hospital_charge = 0
    end
    procedure = Procedure.find_by_drg_id(39).drg_def
    il_charge = (Procedure.find_by_drg_id(39).avg_covered_charges_IL/1000)
    natl_charge = (Procedure.find_by_drg_id(39).natl_avg_total_payments/1000)
    {hospital_charge: hospital_charge, il_charge: il_charge, natl_charge: natl_charge, hospital_id: provider_id, procedure: procedure}
  end

end

  

