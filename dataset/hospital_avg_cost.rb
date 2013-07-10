Hospital.all.each do |h|
  h.hospitals_procedures.each do |hp|
    hosp_acc = hp.avg_covered_charges
    natl_acc = h.procedures.find_by_drg_id(hp.drg_id).natl_avg_covered_charges
    diff = hosp_acc - natl_acc
    index = diff / natl_acc
    p h.provider_name, h.provider_id, hp.avg_covered_charges, diff, hp.drg_id, index
    p '<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
  end
end;false
