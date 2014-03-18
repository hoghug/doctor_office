require 'spec_helper'

describe Doctor do

  it 'initializes the Doctor class'  do
    test_doctor = Doctor.new({'name' => 'Dr. Pepper', 'specialty' => 'Surgeon', 'insurance' => 'KP'})
    test_doctor.should be_an_instance_of Doctor
  end

  it 'creates a new specialty class and assigns its specialty id' do
    test_specialty = Specialty.new("Surgeon")
    test_doctor = Doctor.new({'name' => 'Dr. Pepper', 'specialty' => 'Surgeon', 'insurance' => 'KP'})
    test_doctor.save
    test_doctor.specialty_id.should eq test_specialty.id
  end

  it 'saves itself to the database and returns its id' do
    test_doctor = Doctor.new({'name' => 'Dr. Pepper', 'specialty' => 'Surgeon', 'insurance' => 'KP'})
    test_doctor.save
    test_doctor.id.should be_an_instance_of Fixnum
  end

  it 'creates an array with all known doctors in the database' do
    test_doctor1 = Doctor.new({'name' => 'Dr. Pepper', 'specialty' => 'Surgeon', 'insurance' => 'KP'})
    test_doctor1.save
    test_doctor2 = Doctor.new({'name' => 'Dr. Evil', 'specialty' => 'Proctologist', 'insurance' => 'Red Cross'})
    test_doctor2.save
    test_doctor3 = Doctor.new({'name' => 'Dr. Manhattan', 'specialty' => 'ENT', 'insurance' => 'Blue Shield'})
    test_doctor3.save
    Doctor.all.should eq [test_doctor1, test_doctor2, test_doctor3]
  end

  it 'populates self.all with objects recreated from data in the database'  do
    test_doctor1 = Doctor.new({'name' => 'Dr. Pepper', 'specialty' => 'Surgeon', 'insurance' => 'KP'})
    test_doctor1.save
    p test_doctor1
    test_doctor1 = []
    p Doctor.all[0]
  end

  it 'deletes the specified patient' do
    new_doctor1 = Doctor.new({'name' => 'Dr. Pepper', 'specialty' => 'Surgeon', 'insurance' => 'KP'})
    new_doctor1.save
    new_doctor2 = Doctor.new({'name' => 'Dr. Manhattan', 'specialty' => 'ENT', 'insurance' => 'Aetna'})
    new_doctor2.save
    Doctor.delete(new_doctor1.id)
    Doctor.all.should eq [new_doctor2]
  end

end
