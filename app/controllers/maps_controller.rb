class MapsController < ApplicationController

  def index
    hospitals = Hospital.all

    @all_hospitals = []

    hospitals.each do |hospital|
      @all_hospitals << hospital.as_json(only: [:provider_name, :latitude, :longitude, :provider_id])
    end

    # @all_hospitals
  end

end

# [
#  {"latitude"=>37.7308956, "longitude"=>-88.5248335, "provider_id"=>140210, "provider_name"=>"HARRISBURG MEDICAL CENTER"}, 
#  {"latitude"=>41.6781639, "longitude"=>-87.6376566, "provider_id"=>140304, "provider_name"=>"ADVENTIST BOLINGBROOK HOSPITAL"}
# ]
