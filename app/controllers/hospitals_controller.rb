class HospitalsController < ApplicationController

  def index
    @hospitals = Hospital.all
  end

  def show
    @hospital = Hospital.find(params[:id])
  end

  def infobox
    drg_description = params.keys[0]
    hospital = Hospital.find_by_provider_id(params[:id])
    data = hospital.infobox_on_click(drg_description).to_json
    respond_to do |format|
      format.json { render :json => data }
    end
  end

  def outcomebox
    hospital = Hospital.find_by_provider_id(params[:id])
    data = hospital.outcomebox_on_click.to_json
    respond_to do |format|
      format.json { render :json => data }
    end
  end

end
