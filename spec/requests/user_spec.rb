require 'spec_helper'

describe "A user can see " do 

	context "on home page that it" do

		before(:each) do
			visit root_path
		end
		
		# it "hides left side bar when details clicked", :js=> true do
		# 	click_link 'search by'
		# 	page.find("#procdropdown_chzn").visible?.should be_false
		# end

		it 'is on the proper page' do
			current_path.should == root_path
		end
			
		it "displays nav bar" do
			page.should have_content 'Bubble Visualizations'
		end

		it "displays tabs nav icon" do
			page.should have_content "Top Medical Procedures"
		end

		# it 'shows green circles when average cost is clicked', :js=> true do
		# 	click_link("#acc")
		# 	page.should have_css("img", :src => "https://maps.gstatic.com/mapfiles/transparent.png")
		# end

		it "displays correct information when static page clicked" do
			click_link 'About us'
			page.should have_content 'Panlilio'
		end

		it 'finds the icons in the nav bar' do
			page.find(:css, '#acc')
		end
	end
end

