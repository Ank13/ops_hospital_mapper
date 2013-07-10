class HospitalsController < ApplicationController

  def index
    @hospitals = Hospital.all
  end

  def show
    @hospital = Hospital.find(params[:id])
    render :layout => false
  end

  def infobox
    drg_description = params[:drg].upcase
    hospital = Hospital.find_by_provider_id(params[:id])
    # data = hospital.infobox_on_click(drg_description).to_json
    # respond_to do |format|
    #   format.json { render :json => data }
    # end

    # FIXME: this REALLY shouldnt be a model method - move to helper, eg:
    # render :json => hospital_infobox(hospital)
    render :json => hospital.infobox_on_click(drg_description).to_json
  end

  def outcomebox
    hospital = Hospital.find_by_provider_id(params[:id])
    # data = hospital.outcomebox_on_click.to_json
    # respond_to do |format|
    #   format.json { render :json => data }
    # end

    # FIXME: this REALLY shouldnt be a model method - move to helper, eg:
    # render :json => hospital_outcomebox(hospital)
    render :json => hospital.outcomebox_on_click.to_json
  end

  def complicationbox
    hospital = Hospital.find_by_provider_id(params[:id])
    data = hospital.complicationbox_on_click.to_json
    respond_to do |format|
      format.json { render :json => data }
    end

    # FIXME: same feedback as the other controller actions
  end

end
