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
    csv_state_procedure_path = Rails.root.join("dataset", "procedures_state_avg_usa.csv")
    CSV.foreach(csv_state_procedure_path, :headers => true) do |row|
      StatesProcedure.create!(row.to_hash)
    end
  end
end


csv_hospital_procedure_path = Rails.root.join("dataset", "cms_chargemaster_inpatient_2011.csv")
CSV.foreach(csv_hospital_procedure_path, :headers => true) do |row|
HospitalsProcedure.new(row.to_hash)

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
