namespace :db do
  desc "calculate and insert cost index per hospital per procedure"
  task :calc_cost_index => :environment do

    Hospital.all.each do |h|
      h.hospitals_procedures.each do |hp|
        hosp_acc = hp.avg_covered_charges
        natl_acc = h.procedures.find_by_drg_id(hp.drg_id).natl_avg_covered_charges
        diff = hosp_acc - natl_acc
        index = diff / natl_acc
        hp.cost_index = index * 100
        hp.save
      end
      h.total_cost_index = h.hospitals_procedures.average('cost_index').to_i
      h.save
    end
  end

end

