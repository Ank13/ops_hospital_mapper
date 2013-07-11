require 'spec_helper'

describe Complication do
	it { should be_instance_of(Complication) }

  it { should belong_to(:hospital) }

  it { should validate_presence_of(:hospital) }

end
