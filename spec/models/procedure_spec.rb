require 'spec_helper'

describe Procedure do

  it { should have_many(:hospitals_procedures) }
  it { should have_many(:hospitals) }
end
