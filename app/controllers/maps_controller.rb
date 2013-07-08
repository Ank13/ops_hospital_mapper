class MapsController < ApplicationController

  def index
    lat ||= 41.7700
    long ||= -87.9000
    distance ||= 100
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

end
