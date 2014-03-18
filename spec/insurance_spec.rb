require 'spec_helper'

describe Insurance do
  it 'initializes the Insurance class'  do
    test_insurance = Insurance.new("Aetna")
    test_insurance.should be_an_instance_of Insurance
  end

  it 'saves itself and returns the id' do
    test_insurance = Insurance.new("Aetna")
    test_insurance.save
    test_insurance.id.should be_an_instance_of Fixnum
  end

  it 'returns a single id if 2 insurance cos share the same name' do
    test_insurance1 = Insurance.new("Aetna")
    test_insurance1.save
    test_insurance2 = Insurance.new("Aetna")
    test_insurance2.save
    test_insurance1.id.should eq test_insurance2.id
  end
end
