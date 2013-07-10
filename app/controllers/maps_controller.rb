class MapsController < ApplicationController

  def index
    # it might be nice to wrap this in a helper that's more expressive, eg.
    # clear_hospital_browsing_cache!
    session[:hospital_ids] = []
    box = Geocoder::Calculations.bounding_box([41.8899109, -87.6376566], 10)
    hospitals = Hospital.geocoded.within_bounding_box(box)
    @all_hospitals = Hospital.find_hospitals_for_map(hospitals)
    # line 6 + 7 can be combined into a single class method instead of two, no?
    @procedures = Procedure.all
  end

  def more_markers
    lat = params[:lat]
    lng = params[:lng]
    distance = params[:distance]
    box = Geocoder::Calculations.bounding_box([lat, lng], distance)
    hospitals = Hospital.geocoded.within_bounding_box(box)

    # can't the next two lines be written as: hospitals.collect! { ! session[:hospital_ids].include?(hospital.provider_id) }
    more_hospitals = []
    hospitals.each {|hospital| more_hospitals << hospital unless session[:hospital_ids].include?(hospital.provider_id)}

    # FAT MODELS skinny controllers... once again, this line and line 17 can be combined into a single model method
    data = Hospital.find_hospitals_for_map(more_hospitals)

    # be careful with this, session cookies have a size limit...
    session[:hospital_ids] = data.map{|hospital| hospital[:provider_id] }

    render :json => data
  end

  def popup
    render :layout => false
  end

end
