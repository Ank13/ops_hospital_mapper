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
      if !@@loaded.has_key?(hospital.provider_id)
        data << {provider_name: hospital.provider_name, latitude: hospital.latitude, longitude: hospital.longitude, 
          provider_id: hospital.provider_id, infobox_html: hospital.infobox_html_on_load, acc: acc}
        @@loaded[hospital.provider_id] = true
      end
    end

    respond_to do |format|
      format.json { render :json => data }
    end
  end
  
end
