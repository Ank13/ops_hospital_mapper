require 'spec_helper'

describe "A user can" do 

	context "on home page" do

		it "displays nav bar" do
			visit root_path
			expect(page).to have_content("WTF medicare")
		end

		it "displays correct procedure information" do
			visit root_path
			within '#date' do
			  find("option[value='305 - HYPERTENSION W/O MCC']").click
			  # dont know how to click a hospital on maps via capybara
			end
		end

	end		

end