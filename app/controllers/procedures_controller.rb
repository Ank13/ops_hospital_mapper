class ProceduresController < ApplicationController

  def prices

    loaded_IDs = params[:loadedIDs].map{|id| id.to_i }
    code = params[:drg][0..2]
    procedure = Procedure.find_by_drg_id(code)
    procedures = HospitalsProcedure.includes(:hospital).find_all_by_drg_id(procedure.drg_id)
    procedures.select!{|procedure| procedure if loaded_IDs.include?(procedure.provider_id)}

    data = []
    procedures.each do |procedure|
      data << { latitude: procedure.hospital.latitude, longitude: procedure.hospital.longitude,
               avg_cost: (procedure.avg_covered_charges/1000).round(1)}.to_json
    end

    respond_to do |format|
      format.json { render :json => data }
    end
  end
end
