require 'spec_helper'

describe HospitalsController do
	render_views

	context "render GET views" do
		it "should render index" do
			get :index
			response.should render_template :index
		end
	
	  it "should render show" do
	  	hospital = FactoryGirl.create(:hospital)
	  	get :show, provider_id: hospital
	  	response.should render_template :show
		end
	end
end 
