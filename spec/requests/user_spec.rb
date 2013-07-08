require 'spec_helper'

describe "A user can" do 

	context "on home page" do

		before(:each) do
			visit root_path
		end

		it 'is on the proper page' do
			current_path.should == root_path
		end
			
		it "displays nav bar" do
			page.should have_content 'WTF'
		end

		it "displays details nav icon" do
			page.should have_content "Details"

		end

		it "hides left side bar when details clicked" do
			click_link 'Details'
			page.should_not have_content 'PATIENT SURVEYS'

		end

		it "displays correct information when static page clicked" do
			click_link 'datasets'
			page.should have_content 'CMS'
		end
	end		

end
