class HospitalsController < ApplicationController

  def index
    @hospitals = Hospital.all
  end

  def show
    @hospital = Hospital.find(params[:id])
  end

  def infobox
    hospital = Hospital.find_by_provider_id(params[:id])
    data = hospital.infobox_on_click.to_json
    respond_to do |format|
      format.json { render :json => data }
    end
  end

end
