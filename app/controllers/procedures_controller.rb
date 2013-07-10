class ProceduresController < ApplicationController

  def prices

    loaded_IDs = params[:loadedIDs].map{|id| id.to_i }
    code = params[:drg][0..2] # what is this?
    procedure = Procedure.find_by_drg_id(code)
    procedures = HospitalsProcedure.find_all_by_drg_id(procedure.drg_id)
    procedures.select!{|procedure| procedure if loaded_IDs.include?(procedure.provider_id)}

    # wrap this logic into a helper
    data = []
    procedures.each do |procedure|
      data << { latitude: procedure.hospital.latitude, longitude: procedure.hospital.longitude,
               avg_cost: (procedure.avg_covered_charges/1000).round(1)}.to_json
    end

    render :json => data
  end
end
