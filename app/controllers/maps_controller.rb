class MapsController < ApplicationController

  def index
    hospitals = Hospital.all
    @procedures = Procedure.all
    @all_hospitals = []
    hospitals.each do |hospital|
      acc = hospital.average_covered_charges/2000

      @all_hospitals << {provider_name: hospital.provider_name, latitude: hospital.latitude, longitude: hospital.longitude, 
        provider_id: hospital.provider_id, infobox_html: hospital.infobox_html_on_load, acc: acc}
    end
  end

end
