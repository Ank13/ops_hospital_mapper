require 'spec_helper'

describe Outcome do 
	
	it { should be_instance_of(Outcome) }
  it { should belong_to (:hospital) }


end
