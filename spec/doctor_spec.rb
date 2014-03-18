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


  it 'deletes the specified patient' do
    new_doctor1 = Doctor.new({'name' => 'Dr. Pepper', 'specialty' => 'Surgeon', 'insurance' => 'KP'})
    new_doctor1.save
    new_doctor2 = Doctor.new({'name' => 'Dr. Manhattan', 'specialty' => 'ENT', 'insurance' => 'Aetna'})
    new_doctor2.save
    Doctor.delete(new_doctor1.id)
    Doctor.all.should eq [new_doctor2]
  end

  it 'adds a doctor/patient combo to doctors_patients table' do
    test_doctor1 = Doctor.new({'name' => 'Dr. Pepper', 'specialty' => 'Surgeon', 'insurance' => 'KP'})
    test_doctor1.save
    new_patient1 = Patient.new({'name' => 'John Stamos', 'birthdate' => '1963-08-19', 'insurance' => 'Aetna'})
    new_patient1.save
    Doctor.patient_doctor_add(new_patient1.id, test_doctor1.id)
    result = DB.exec("SELECT * FROM doctors_patients WHERE patient_id = #{new_patient1.id} AND doctor_id = #{test_doctor1.id};")
    result.first['patient_id'].to_i.should eq new_patient1.id
  end

  it 'creates a list of patients assigned to this doctor upon initialization' do
    test_doctor = Doctor.new({'name' => 'Dr. Seuss', 'specialty' => 'OBGYN', 'insurance' => 'Blue Shield'})
    test_doctor.save
    test_patient = Patient.new({'name' => 'John Stamos', 'birthdate' => '1963-08-19', 'insurance' => 'Aetna'})
    test_patient.save
    Doctor.patient_doctor_add(test_patient.id, test_doctor.id)
    # test_doctor.patient_list.should eq [test_patient.id]
    Doctor.patient_list(test_doctor.id).should eq [test_patient.name]

  end

end
