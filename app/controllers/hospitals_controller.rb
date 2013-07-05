class HospitalsController < ApplicationController

  def index
    @hospitals = Hospital.all
  end

  def show
    @hospital = Hospital.find(params[:id])
  end
end
