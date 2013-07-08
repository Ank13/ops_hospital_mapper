class MapsController < ApplicationController

  def index
    hospitals = Hospital.all
    @procedures = Procedure.all
    @all_hospitals = []
    hospitals.each do |hospital|
      acc = hospital.average_covered_charges/1600

      unless hospital.patient_survey.nil? #|| hospital.patient_survey.recommend_y = 0
        thumbs_up = hospital.patient_survey.recommend_y*50 
        # puts thumbs_up
        @all_hospitals << {provider_name: hospital.provider_name, latitude: hospital.latitude, longitude: hospital.longitude, 
        provider_id: hospital.provider_id, infobox_html: hospital.infobox_html_on_load, acc: acc, thumbs_up: thumbs_up}
      else
        @all_hospitals << {provider_name: hospital.provider_name, latitude: hospital.latitude, longitude: hospital.longitude, 
        provider_id: hospital.provider_id, infobox_html: hospital.infobox_html_on_load, acc: acc}
      end
      puts acc
      # @all_hospitals
      # puts thumbs_up
    end
  end
end
