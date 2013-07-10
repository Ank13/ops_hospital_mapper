class MapsController < ApplicationController

  def index
    session[:hospital_ids] = []
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
    hospitals = Hospital.geocoded.within_bounding_box(box).includes(:outcome, :patient_survey)
    
    more_hospitals = []
    hospitals.each {|hospital| more_hospitals << hospital unless session[:hospital_ids].include?(hospital.provider_id)}
    data = Hospital.find_hospitals_for_map(more_hospitals)
    session[:hospital_ids] = data.map{|hospital| hospital[:provider_id] }

    respond_to do |format|
      format.json { render :json => data }
    end
  end

  def popup
    render :layout => false
  end
  
  def analytics
    id = params[:drg][0..2]
    @procedure = Procedure.find_by_drg_id(id)

    render :layout => false
  end
end
