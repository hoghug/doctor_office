require 'spec_helper'

describe Specialty do
  it 'initializes the Specialty class'  do
    test_specialty = Specialty.new("Surgeon")
    test_specialty.should be_an_instance_of Specialty
  end

  it 'saves itself and returns the id' do
    test_specialty = Specialty.new("Surgeon")
    test_specialty.save
    test_specialty.id.should be_an_instance_of Fixnum
  end

  it 'returns a single id if 2 specialties share the same name' do
    test_specialty1 = Specialty.new("Surgeon")
    test_specialty1.save
    test_specialty2 = Specialty.new("Surgeon")
    test_specialty2.save
    test_specialty1.id.should eq test_specialty2.id
  end
end
