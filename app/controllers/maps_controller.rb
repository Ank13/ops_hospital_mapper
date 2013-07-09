class MapsController < ApplicationController

  def index
    hospitals = Hospital.all
    @procedures = Procedure.all
    @all_hospitals = []
    hospitals.each do |hospital|
      acc = hospital.average_covered_charges/1600

      unless hospital.patient_survey.nil? || hospital.patient_survey.recommend_no.nil? || hospital.outcome.nil? || hospital.outcome.mr_h_a.nil? || hospital.outcome.mr_hf.nil? || hospital.outcome.mr_p.nil?
        thumbs_up = (hospital.patient_survey.recommend_y + hospital.patient_survey.recommend_ok)*40 
        thumbs_down = hospital.patient_survey.recommend_no*50
        mortality = (hospital.outcome.mr_h_a + hospital.outcome.mr_hf + hospital.outcome.mr_p)/2
        # puts thumbs_up
        @all_hospitals << {provider_name: hospital.provider_name, latitude: hospital.latitude, longitude: hospital.longitude, 
        provider_id: hospital.provider_id, infobox_html: hospital.infobox_html_on_load, acc: acc, thumbs_up: thumbs_up, thumbs_down: thumbs_down, mortality: mortality}
      else
        @all_hospitals << {provider_name: hospital.provider_name, latitude: hospital.latitude, longitude: hospital.longitude, 
        provider_id: hospital.provider_id, infobox_html: hospital.infobox_html_on_load, acc: acc}
      end
    end
  end
end
