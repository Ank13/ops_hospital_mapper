require 'spec_helper'

describe Procedure do

	it { should be_instance_of(Procedure) }

  it { should have_many(:hospitals_procedures) }
  it { should have_many(:hospitals) }

  context 'public methods' do

  	before(:each) do
  		@procedure = FactoryGirl.create(:procedure)
  		# @procedures.hospitals_procedures =  
  	end

  	# it 'should return most expensive hospital for a given procedure' do
  	# 	@procedure.most_expensive_hospital.should eq('Mercy Hospital')
  	# end

  end
end
