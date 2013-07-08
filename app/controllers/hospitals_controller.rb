class HospitalsController < ApplicationController

  def index
    @hospitals = Hospital.all
  end

  def show
    @hospital = Hospital.find(params[:id])
  end

  def infobox
    drg_description = params.keys[0] # im not sure what this code is but i dont understand it or like it. therefore, move it into a separate wrapper method so its more expressive
    hospital = Hospital.find_by_provider_id(params[:id])
    data = hospital.infobox_on_click(drg_description).to_json
    respond_to do |format|
      format.json { render :json => data }
    end
  end

end
