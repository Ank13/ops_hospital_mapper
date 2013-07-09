class ProceduresController < ApplicationController

  def prices
    code = params[:drg][0..2]
    procedure = Procedure.find_by_drg_id(code)
    procedures = HospitalsProcedure.find_all_by_drg_id(procedure.drg_id)

    data = []
    procedures.each do |procedure|
      data << { latitude: procedure.hospital.latitude, longitude: procedure.hospital.longitude,
               avg_cost: procedure.avg_covered_charges}.to_json
    end

    respond_to do |format|
      format.json { render :json => data }
    end
  end

end
