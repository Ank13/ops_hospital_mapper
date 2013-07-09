class MapsController < ApplicationController

  @@loaded = {} 

  def index
    @procedures = Procedure.all
  end


  def more_markers
    lat = params[:lat]
    lng = params[:lng]
    distance = params[:distance]
    box = Geocoder::Calculations.bounding_box([lat, lng], distance)
    hospitals = Hospital.geocoded.within_bounding_box(box)

    data = []
    hospitals.each do |hospital|
      acc = hospital.average_covered_charges/1600
    #   if !@@loaded.has_key?(hospital.provider_id)
    #     data << {provider_name: hospital.provider_name, latitude: hospital.latitude, longitude: hospital.longitude, 
    #       provider_id: hospital.provider_id, infobox_html: hospital.infobox_html_on_load, acc: acc}
    #     @@loaded[hospital.provider_id] = true
    #   end
    # end
  
        if !@@loaded.has_key?(hospital.provider_id)
          unless hospital.patient_survey.nil? || hospital.patient_survey.recommend_no.nil? || hospital.outcome.nil? || hospital.outcome.mr_h_a.nil? || hospital.outcome.mr_hf.nil? || hospital.outcome.mr_p.nil?
            thumbs_up = (hospital.patient_survey.recommend_y + hospital.patient_survey.recommend_ok)*40 
            thumbs_down = hospital.patient_survey.recommend_no*50
            mortality = (hospital.outcome.mr_h_a + hospital.outcome.mr_hf + hospital.outcome.mr_p)/2
            data << {provider_name: hospital.provider_name, latitude: hospital.latitude, longitude: hospital.longitude, 
            provider_id: hospital.provider_id, infobox_html: hospital.infobox_html_on_load, acc: acc, thumbs_up: thumbs_up, thumbs_down: thumbs_down, mortality: mortality}
            @@loaded[hospital.provider_id] = true
          else
            data << {provider_name: hospital.provider_name, latitude: hospital.latitude, longitude: hospital.longitude, 
            provider_id: hospital.provider_id, infobox_html: hospital.infobox_html_on_load, acc: acc}
            @@loaded[hospital.provider_id] = true
          end
        end
      end
    respond_to do |format|
      format.json { render :json => data }
    end
  end
end
