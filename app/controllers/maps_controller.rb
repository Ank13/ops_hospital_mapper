class MapsController < ApplicationController
  @@loaded = {foo: 'bar'} 

  def index
    @@loaded.clear 
    box = Geocoder::Calculations.bounding_box([41.8899109, -87.6376566], 10)
    hospitals = Hospital.geocoded.within_bounding_box(box)
    @all_hospitals = Hospital.find_hospitals_for_map(hospitals)
    @procedures = Procedure.all
  end


  def more_markers
    lat = params[:lat]
    lng = params[:lng]
    distance = params[:distance]
    box = Geocoder::Calculations.bounding_box([lat, lng], distance)
    hospitals = Hospital.geocoded.within_bounding_box(box)
    
    more_hospitals = []
    hospitals.each {|hospital| more_hospitals << hospital if !@@loaded.has_key?(hospital.provider_id)}
    data = Hospital.find_hospitals_for_map(more_hospitals)
    data.each{|hospital| @@loaded[hospital[:provider_id]] = 'true' }

    respond_to do |format|
      format.json { render :json => data }
    end
  end
end
