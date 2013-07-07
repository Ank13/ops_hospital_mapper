require 'spec_helper'

describe MapsController do
	render_views

	context "renders GET views" do
		it "should render index" do
			get :index
			response.should render_template :index
		end
	end
end