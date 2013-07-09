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

		it "displays tabs nav icon" do
			page.should have_content "search by"
		end

		it "hides left side bar when details clicked", :js=> true do
			sleep(1)
			click_link 'search by'
			sleep(5)
			page.should_not have_content 'procedures'
		end

		it 'shows red circles when average cost is clicked', :js=> true do
			sleep(3)
			click_link 'Average Cost (all procedures)'
			page.should have_css("img", :src => "https://maps.gstatic.com/mapfiles/transparent.png")
		end

		it "displays correct information when static page clicked" do
			click_link 'datasets'
			page.should have_content 'CMS'
		end


		it 'clicks on a map icon', :js => true do
			sleep(5)

		end
	end		 

		it "should display google location search box" do
			page.should have_content "hospital or location"
		end
	end
end

