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

  def infobox_html
    unless self.patient_survey.nil? && self.outcome.nil?
      return "<div class='info-box'> #{provider_name} </div>
              <p><a href='#'>Comparison Details</a></p>
              <ul>
                <li> #{(patient_survey.recommend_y * 100).round(0)}% of patients recommend this hospital</li>
                <li> Survey response rate: #{(patient_survey.survey_response_rate * 100).round(0)}%</li>
                <li> Readmission rate from heart attack: #{outcome.readm_ha }</li>
                <li> Reported discharges: #{total_discharges}</li>
                <li> Average Covered Charges (all procedures): $#{(average_covered_charges/1000).round(0)}K</li>
                <li> Average Total Payment (all procedures): $#{(average_total_payments/1000).round(0)}K</li>
              </ul>"
    else
      return "<div class='info-box'> #{provider_name} </div>
              <ul>
                <li> Average Covered Charges (all procedures): $#{(average_covered_charges/1000).round(0)}K</li>
                <li> Average Total Payment (all procedures): $#{(average_total_payments/1000).round(0)}K</li>
              </ul>"
    end
  end

end

  

