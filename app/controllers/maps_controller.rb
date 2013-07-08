class MapsController < ApplicationController

  def index
    lat ||= 41.7700
    long ||= -87.9000
    distance ||= 5
    box = Geocoder::Calculations.bounding_box([lat, long], distance)

    hospitals = Hospital.geocoded.within_bounding_box(box)
    @procedures = Procedure.all
    @all_hospitals = []
    hospitals.each do |hospital|
      acc = hospital.average_covered_charges/1600
      @all_hospitals << {provider_name: hospital.provider_name, latitude: hospital.latitude, longitude: hospital.longitude, 
        provider_id: hospital.provider_id, infobox_html: hospital.infobox_html_on_load, acc: acc}
    end
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
      data << {provider_name: hospital.provider_name, latitude: hospital.latitude, longitude: hospital.longitude, 
        provider_id: hospital.provider_id, infobox_html: hospital.infobox_html_on_load, acc: acc}
    end

    respond_to do |format|
      format.json { render :json => data }
    end
  end
  
end
