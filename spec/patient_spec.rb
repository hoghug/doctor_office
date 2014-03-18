require 'spec_helper'

describe Patient do
  it 'will create an instance of a Patient' do
    new_patient = Patient.new({'name' => 'John Stamos', 'birthdate' => '1968-12-17', 'insurance' => 'Aetna'})
    new_patient.should be_an_instance_of Patient
  end

  it 'checks if the patient\'s insurance already exists and returns that ins_id' do
    new_insurance = Insurance.new('Aetna')
    new_patient = Patient.new({'name' => 'John Stamos', 'birthdate' => '1968-12-17', 'insurance' => 'Aetna'})
    new_patient.save
    new_patient.insurance_id.should eq new_insurance.id
  end

  it 'deletes the specified patient' do
    new_patient1 = Patient.new({'name' => 'John Stamos', 'birthdate' => '1968-12-17', 'insurance' => 'Aetna'})
    new_patient1.save
    new_patient2 = Patient.new({'name' => 'Dave Coulier', 'birthdate' => '1970-10-12', 'insurance' => 'KP'})
    new_patient2.save
    Patient.delete(new_patient1.id)
    Patient.all.should eq [new_patient2]
  end

end
