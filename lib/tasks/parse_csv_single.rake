require 'csv'

namespace :db do
  desc "parse csv files for hospital database"
  task :parse_csv_hospitals  => :environment do
    hospital_all = File.open(File.join(Rails.root, "dataset", "hospitals_all_geocoded.csv"),"r")
    csv_hospital_all = CSV.parse(hospital_all, :headers => true)
    csv_hospital_all.each do |row|
      Hospital.create!(row.to_hash)
    end
  end
end

namespace :db do
  desc "parse csv files for procedure database"
  task :parse_csv_procedures  => :environment do
    procedure_usa = File.open(File.join(Rails.root, "dataset", "procedures_usa_all.csv"),"r")
    csv_procedure_usa = CSV.parse(procedure_usa, :headers => true)
    csv_procedure_usa.each do |row|
      Procedure.create!(row.to_hash)
    end
  end
end

namespace :db do
  desc "parse csv files for hospitals_procedures database"
  task :parse_csv_hospitals_procedures  => :environment do
    hosp_procedure_il = File.open(File.join(Rails.root, "dataset", "cms_chargemaster_inpatient_2011_il.csv"),"r")
    csv_hosp_procedure_il = CSV.parse(hosp_procedure_il, :headers => true)
    csv_hosp_procedure_il.each do |row|
      HospitalsProcedure.create!(row.to_hash)
    end

    hosp_procedure_usa = File.open(File.join(Rails.root, "dataset", "cms_chargemaster_inpatient_2011_usa.csv"),"r")
    csv_hosp_procedure_usa = CSV.parse(hosp_procedure_usa, :headers => true)
    csv_hosp_procedure_usa.each do |row|
      HospitalsProcedure.create!(row.to_hash)
    end
  end
end

namespace :db do
  desc "parse csv files for outcomes database"
  task :parse_csv_outcomes  => :environment do
    outcome_il = File.open(File.join(Rails.root, "dataset", "hospital_mortality_il.csv"),"r")
    csv_outcome_il = CSV.parse(outcome_il, :headers => true)
    csv_outcome_il.each do |row|
      Outcome.create!(row.to_hash)
    end

    outcome_usa = File.open(File.join(Rails.root, "dataset", "hospital_mortality_usa.csv"),"r")
    csv_outcome_usa = CSV.parse(outcome_usa, :headers => true)
    csv_outcome_usa.each do |row|
      Outcome.create!(row.to_hash)
    end
  end
end

namespace :db do
  desc "parse csv files for complications database"
  task :parse_csv_complications  => :environment do
    complications_il = File.open(File.join(Rails.root, "dataset", "agency_for_healthcare_research_and_quality_measures_il.csv"),"r")
    csv_complications_il = CSV.parse(complications_il, :headers => true)
    csv_complications_il.each do |row|
      Complication.create!(row.to_hash)
    end

    complications_usa = File.open(File.join(Rails.root, "dataset", "agency_for_healthcare_research_and_quality_measures_usa.csv"),"r")
    csv_complications_usa = CSV.parse(complications_usa, :headers => true)
    csv_complications_usa.each do |row|
      Complication.create!(row.to_hash)
    end
  end
end

namespace :db do
  desc "parse csv files for patient_surveys database"
  task :parse_csv_patient_surveys  => :environment do
    surveys_il = File.open(File.join(Rails.root, "dataset", "patient_survey_il.csv"),"r")
    csv_surveys_il = CSV.parse(surveys_il, :headers => true)
    csv_surveys_il.each do |row|
      PatientSurvey.create!(row.to_hash)
    end

    surveys_usa = File.open(File.join(Rails.root, "dataset", "patient_survey_usa.csv"),"r")
    csv_surveys_usa = CSV.parse(surveys_usa, :headers => true)
    csv_surveys_usa.each do |row|
      PatientSurvey.create!(row.to_hash)
    end
  end
end
