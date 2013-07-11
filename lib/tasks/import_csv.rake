require 'csv'

namespace :import do
  desc "import csv files for hospital database"
  task :csv_hospitals  => :environment do
  	csv_hospital_geocoded_path = Rails.root.join("dataset", "hospitals_all_geocoded.csv")
    CSV.foreach(csv_hospital_geocoded_path, :headers => true) do |row|
      Hospital.create!(row.to_hash)
    end
  end

  desc "import csv files for procedure database"
  task :usa_procedures  => :environment do
    csv_procedure_path = Rails.root.join("dataset", "procedures_usa_all.csv")
    CSV.foreach(csv_procedure_path, :headers => true) do |row|
      Procedure.create!(row.to_hash)
    end
  end

  desc "import csv files for hospitals_procedures database"
  task :csv_hospitals_procedures  => :environment do
    csv_hosp_procedure_il_path = Rails.root.join("dataset", "cms_chargemaster_inpatient_2011_il.csv")
    CSV.foreach(csv_hosp_procedure_il_path, :headers => true) do |row|
      HospitalsProcedure.create!(row.to_hash)
    end

    csv_hosp_procedure_usa_path = Rails.root.join("dataset", "cms_chargemaster_inpatient_2011_usa.csv")
    CSV.foreach(csv_hosp_procedure_usa_path, :headers => true) do |row|
      HospitalsProcedure.create!(row.to_hash)
    end
  end

  desc "import csv files for outcomes database"
  task :csv_outcomes  => :environment do
    csv_outcome_il_path = Rails.root.join("dataset", "hospital_mortality_il.csv")
    CSV.foreach(csv_outcome_il_path, :headers => true) do |row|
      Outcome.create!(row.to_hash)
    end

    csv_outcome_usa_path = Rails.root.join("dataset", "hospital_mortality_usa.csv")
    CSV.foreach(csv_outcome_usa_path, :headers => true) do |row|
      Outcome.create!(row.to_hash)
    end
  end

  desc "import csv files for complications database"
  task :csv_complications  => :environment do
    csv_complications_il_path = Rails.root.join("dataset", "agency_for_healthcare_research_and_quality_measures_il.csv")
    CSV.foreach(csv_complications_il_path, :headers => true) do |row|
      Complication.create!(row.to_hash)
    end

    csv_complications_usa_path = Rails.root.join("dataset", "agency_for_healthcare_research_and_quality_measures_usa.csv")
    CSV.foreach(csv_complications_usa_path, :headers => true) do |row|
      Complication.create!(row.to_hash)
    end
  end

  desc "import csv files for patient_surveys database"
  task :csv_patient_surveys  => :environment do
    csv_surveys_il_path = Rails.root.join("dataset", "patient_survey_il.csv")
    CSV.foreach(csv_surveys_il_path, :headers => true) do |row|
      PatientSurvey.create!(row.to_hash)
    end

    csv_surveys_usa_path = Rails.root.join("dataset", "patient_survey_usa.csv")
    CSV.foreach(csv_surveys_usa_path, :headers => true) do |row|
      PatientSurvey.create!(row.to_hash)
    end
  end

  desc "import csv files for procedure database"
  task :csv_stateprocedure  => :environment do
    csv_state_procedure_path = Rails.root.join("dataset", "procedures_state_avg_usa.csv")
    CSV.foreach(csv_state_procedure_path, :headers => true) do |row|
      StatesProcedure.create!(row.to_hash)
    end
  end

  desc "import csv files for procedures database new fields: description and clinical_category" 
  task :csv_procedure_description => :environment do
    csv_procedure_path = Rails.root.join("dataset", "procedure_definitions.csv")
    CSV.foreach(csv_procedure_path, :headers => true) do |row|
      drg_id = row[0]
      clinical_category = row[1]
      description = row[2]
      procedure = Procedure.find_by_drg_id(drg_id)
      procedure.update_attributes({:description => description, :clinical_category => clinical_category})
    end
  end

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

  # lib/tasks/reset_unimportant_models_task.rake
  desc "Sequentially clears out a model"
  task :reset_unimportant_models => :environment do
    puts "Clearing out the StatesProcedureModel model"
    StatesProcedure.destroy_all
    puts "Finished."
  end

  task :all => [:csv_hospitals, :usa_procedures, :csv_hospitals_procedures, :csv_outcomes,
  :csv_complications, :csv_patient_surveys, :csv_stateprocedure, :csv_procedure_description,
   :calc_cost_index] do
    puts "Import all"
  end

end

