require 'csv'

namespace :db do
  desc "import csv files for hospital database"
  task :import_csv_hospitals  => :environment do
  	csv_hospital_geocoded_path = Rails.root.join("dataset", "hospitals_all_geocoded.csv")
    CSV.foreach(csv_hospital_geocoded_path, :headers => true) do |row|
      Hospital.create!(row.to_hash)
    end
  end
end

namespace :db do
  desc "import csv files for procedure database"
  task :import_usa_procedures  => :environment do
    csv_procedure_path = Rails.root.join("dataset", "procedures_usa_all.csv")
    CSV.foreach(csv_procedure_path, :headers => true) do |row|
      Procedure.create!(row.to_hash)
    end
  end
end

namespace :db do
  desc "import csv files for hospitals_procedures database"
  task :import_csv_hospitals_procedures  => :environment do
    csv_hosp_procedure_il_path = Rails.root.join("dataset", "cms_chargemaster_inpatient_2011_il.csv")
    CSV.foreach(csv_hosp_procedure_il_path, :headers => true) do |row|
      HospitalsProcedure.create!(row.to_hash)
    end

    csv_hosp_procedure_usa_path = Rails.root.join("dataset", "cms_chargemaster_inpatient_2011_usa.csv")
    CSV.foreach(csv_hosp_procedure_usa_path, :headers => true) do |row|
      HospitalsProcedure.create!(row.to_hash)
    end
  end
end

namespace :db do
  desc "import csv files for outcomes database"
  task :import_csv_outcomes  => :environment do
    csv_outcome_il_path = Rails.root.join("dataset", "hospital_mortality_il.csv")
    CSV.foreach(csv_outcome_il_path, :headers => true) do |row|
      Outcome.create!(row.to_hash)
    end

    csv_outcome_usa_path = Rails.root.join("dataset", "hospital_mortality_usa.csv")
    CSV.foreach(csv_outcome_usa_path, :headers => true) do |row|
      Outcome.create!(row.to_hash)
    end
  end
end

namespace :db do
  desc "import csv files for complications database"
  task :import_csv_complications  => :environment do
    csv_complications_il_path = Rails.root.join("dataset", "agency_for_healthcare_research_and_quality_measures_il.csv")
    CSV.foreach(csv_complications_il_path, :headers => true) do |row|
      Complication.create!(row.to_hash)
    end

    csv_complications_usa_path = Rails.root.join("dataset", "agency_for_healthcare_research_and_quality_measures_usa.csv")
    CSV.foreach(csv_complications_usa_path, :headers => true) do |row|
      Complication.create!(row.to_hash)
    end
  end
end

namespace :db do
  desc "import csv files for patient_surveys database"
  task :import_csv_patient_surveys  => :environment do
    csv_surveys_il_path = Rails.root.join("dataset", "patient_survey_il.csv")
    CSV.foreach(csv_surveys_il_path, :headers => true) do |row|
      PatientSurvey.create!(row.to_hash)
    end

    csv_surveys_usa_path = Rails.root.join("dataset", "patient_survey_usa.csv")
    CSV.foreach(csv_surveys_usa_path, :headers => true) do |row|
      PatientSurvey.create!(row.to_hash)
    end
  end
end

namespace :db do
  desc "import csv files for procedure database"
  task :import_csv_stateprocedure  => :environment do
    csv_state_procedure_path = Rails.root.join("dataset", "procedures_state_avg_usa.csv")
    CSV.foreach(csv_state_procedure_path, :headers => true) do |row|
      StatesProcedure.create!(row.to_hash)
    end
  end
end

namespace :db do
  desc "import csv files for procedures database new fields: description and clinical_category" 
  task :import_csv_procedure_description => :environment do
    csv_procedure_path = Rails.root.join("dataset", "procedure_definitions.csv")
    CSV.foreach(csv_procedure_path, :headers => true) do |row|
      drg_id = row[0]
      clinical_category = row[1]
      description = row[2]
      procedure = Procedure.find_by_drg_id(drg_id)
      procedure.update_attributes({:description => description, :clinical_category => clinical_category})
    end
  end
end

# lib/tasks/reset_unimportant_models_task.rake
namespace :db do
  desc "Sequentially clears out a model"
  task :reset_unimportant_models => :environment do
    puts "Clearing out the StatesProcedureModel model"
    StatesProcedure.destroy_all
    puts "Finished."
  end
end

