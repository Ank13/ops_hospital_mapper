class MapsController < ApplicationController

  def index
    hospitals = Hospital.all
    @procedures = Procedure.all
    @all_hospitals = []
    hospitals.each do |hospital|
      # @all_hospitals << hospital.as_json(only: [:provider_name, :latitude, :longitude, 
      #                   :provider_id])

      @all_hospitals << {provider_name: hospital.provider_name, latitude: hospital.latitude, longitude: hospital.longitude, provider_id: hospital.provider_id, infobox_html: hospital.infobox_html_on_load}
    end
  end

end
