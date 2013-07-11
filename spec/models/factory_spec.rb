require 'spec_helper'

describe "Factory" do
	
	it "should have a valid hospital factory" do
		FactoryGirl.create(:hospital).should be_valid
	end

	it "should have a valid procedure factory" do
		FactoryGirl.create(:procedure).should be_valid
	end

	it "should have a valid hospitals procedure factory" do
		FactoryGirl.create(:hospitals_procedure).should be_valid
	end

	it "should have a valid complication factory" do
		FactoryGirl.create(:complication).should be_valid
	end

	it "should have a valid outcome factory" do
		FactoryGirl.create(:outcome).should be_valid
	end

	it "should have a valid patient survey factory" do
		FactoryGirl.create(:patient_survey).should be_valid
	end

	it "should have a valid session factory" do
		FactoryGirl.create(:session).should be_valid
	end

	it "should have a valid states_procedure factory" do
		FactoryGirl.create(:states_procedure).should be_valid
	end

end