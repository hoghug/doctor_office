require 'spec_helper'


describe Appointment do
  it 'will make an instance of Appointment' do
    test_doctor = Doctor.new({'name' => 'Dr. Seuss', 'specialty' => 'OBGYN', 'insurance' => 'Blue Shield'})
    test_doctor.save
    test_patient = Patient.new({'name' => 'John Stamos', 'birthdate' => '1968-12-17', 'insurance' => 'Aetna'})
    test_patient.save
    Doctor.patient_doctor_add(test_patient.id, test_doctor.id)
    result = DB.exec("SELECT * FROM doctors_patients WHERE patient_id = #{test_patient.id} AND doctor_id = #{test_doctor.id};")
    test_appt = Appointment.new(result.first['id'], '2001-09-28 23:00', 200)
    test_appt.should be_an_instance_of Appointment
  end

  it 'stores all appointments in an array' do
    test_doctor = Doctor.new({'name' => 'Dr. Seuss', 'specialty' => 'OBGYN', 'insurance' => 'Blue Shield'})
    test_doctor.save
    test_patient = Patient.new({'name' => 'John Stamos', 'birthdate' => '1963-08-19', 'insurance' => 'Aetna'})
    test_patient.save
    Doctor.patient_doctor_add(test_patient.id, test_doctor.id)
    result = DB.exec("SELECT * FROM doctors_patients WHERE patient_id = #{test_patient.id} AND doctor_id = #{test_doctor.id};")
    test_appt = Appointment.new(result.first['id'], '2001-09-28 23:00', 200)
    test_appt.save
    Appointment.all.should eq [test_appt]
  end

  it 'assigns the doctor for the appointment'  do
    test_doctor = Doctor.new({'name' => 'Dr. Seuss', 'specialty' => 'OBGYN', 'insurance' => 'Blue Shield'})
    test_doctor.save
    test_patient = Patient.new({'name' => 'John Stamos', 'birthdate' => '1963-08-19', 'insurance' => 'Aetna'})
    test_patient.save
    Doctor.patient_doctor_add(test_patient.id, test_doctor.id)
    result = DB.exec("SELECT * FROM doctors_patients WHERE patient_id = #{test_patient.id} AND doctor_id = #{test_doctor.id};")
    test_appt = Appointment.new(result.first['id'], '2001-09-28 23:00', 200)
    test_appt.save
    test_appt.doctor.should eq 'Dr. Seuss'
  end
  it 'assigns the doctor for the appointment'  do
    test_doctor = Doctor.new({'name' => 'Dr. Seuss', 'specialty' => 'OBGYN', 'insurance' => 'Blue Shield'})
    test_doctor.save
    test_patient = Patient.new({'name' => 'John Stamos', 'birthdate' => '1963-08-19', 'insurance' => 'Aetna'})
    test_patient.save
    Doctor.patient_doctor_add(test_patient.id, test_doctor.id)
    result = DB.exec("SELECT * FROM doctors_patients WHERE patient_id = #{test_patient.id} AND doctor_id = #{test_doctor.id};")
    test_appt = Appointment.new(result.first['id'], '2001-09-28 23:00', 200)
    test_appt.save
    test_appt.patient.should eq 'John Stamos'
  end
end
