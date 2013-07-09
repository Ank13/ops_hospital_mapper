require 'csv'

namespace :db do
  desc "parse csv files for hospital database"
  task :parse_csv_hospital  => :environment do
    csv_hospital = File.open(File.join(Rails.root, "dataset", "hospitals_il.csv"),"r")
    csv = CSV.parse(csv_hospital, :headers => true)
    csv.each do |row|
      Hospital.create!(row.to_hash)
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

namespace :db do
  desc "parse csv files for procedure database"
  task :parse_csv_procedure  => :environment do
    csv_procedure = File.open(File.join(Rails.root, "dataset", "procedures.csv"),"r")
    csv = CSV.parse(csv_procedure, :headers => true)
    csv.each do |row|
      Procedure.create!(row.to_hash)
    end
  end
end

namespace :db do
  desc "parse csv files for procedure database"
  task :parse_csv_stateprocedure  => :environment do
    csv_state_procedure = File.open(File.join(Rails.root, "dataset", "procedures_state_avg_usa.csv"),"r")
    csv = CSV.parse(csv_state_procedure, :headers => true)
    csv.each do |row|
      StatesProcedure.create!(row.to_hash)
    end
  end
end

namespace :db do
  desc "parse csv files for hospitals_procedures database"
  task :parse_csv_hospitals_procedures  => :environment do
    csv_hospital_procedure = File.open(File.join(Rails.root, "dataset", "cms_chargemaster_inpatient_2011.csv"),"r")
    csv = CSV.parse(csv_hospital_procedure, :headers => true)
    csv.each do |row|
      HospitalsProcedure.create!(row.to_hash)
    end
  end
end

namespace :db do
  desc "parse csv files for outcomes database"
  task :parse_csv_outcomes  => :environment do
    csv_outcome = File.open(File.join(Rails.root, "dataset", "hospital_mortality.csv"),"r")
    csv = CSV.parse(csv_outcome, :headers => true)
    csv.each do |row|
      Outcome.create!(row.to_hash)
    end
  end
end

namespace :db do
  desc "parse csv files for complications database"
  task :parse_csv_complications  => :environment do
    csv_complication = File.open(File.join(Rails.root, "dataset", "agency_for_healthcare_research_and_quality_measures.csv"),"r")
    csv = CSV.parse(csv_complication, :headers => true)
    csv.each do |row|
      Complication.create!(row.to_hash)
    end
  end
end

namespace :db do
  desc "parse csv files for patient_surveys database"
  task :parse_csv_patient_surveys  => :environment do
    csv_patient_survey = File.open(File.join(Rails.root, "dataset", "patient_survey_il.csv"),"r")
    csv = CSV.parse(csv_patient_survey, :headers => true)
    csv.each do |row|
      PatientSurvey.create!(row.to_hash)
    end
  end
end

namespace :db do
  desc "parse csv files for procedures database new fields: description and clinical_category" 
  task :parse_csv_procedure_description => :environment do
    csv_procedure = File.open(File.join(Rails.root, "dataset", "procedure_definitions.csv"),"r")
    csv = CSV.parse(csv_procedure, :headers => true)
    csv.each do |row|
      drg_id = row[0]
      clinical_category = row[1]
      description = row[2]
      procedure = Procedure.find_by_drg_id(drg_id)
      procedure.update_attributes({:description => description, :clinical_category => clinical_category})
    end
  end
end




