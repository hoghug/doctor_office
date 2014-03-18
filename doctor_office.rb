require './lib/doctor'
require './lib/patient'
require './lib/specialty'
require './lib/insurance'
require 'pg'

DB = PG.connect({:dbname => 'doctor_office'})


def main_menu
  puts "'p': patient menu"
  puts "'d': doctor menu"

  case gets.chomp
  when 'p'
    patient_menu
  when 'd'
    doctor_menu
  else
    main_menu
  end
end

def patient_menu
  puts "Enter 'l' to list all patients."
  puts "Enter 'a' to add a patient."
  puts "Enter 'd' to delete a patient"
  puts "Enter 's' to select a doctor for a patient"
  case gets.chomp
  when 'l'
    list_patients
    main_menu
  when 'a'
    add_patient
  when 'd'
    delete_patient
  when 's'
    see_doctor
  else
    patient_menu
  end
end

def doctor_menu
  puts "Enter 'l' to list all doctors."
  puts "Enter 'a' to add a doctor."
  puts "Enter 'd' to delete a doctor"
  puts "Enter 'p' to show the patient list for a doctor"
  case gets.chomp
  when 'l'
    list_doctors
    main_menu
  when 'a'
    add_doctors
  when 'd'
    delete_doctor
  when 'p'
    doctor_patient_list
  else
    doctor_menu
  end
end


def add_doctors
  list_doctors
  puts "Enter a new doctor in the following format: name|specialty|insurance"
  input_doctor = gets.chomp.split('|')
  new_doctor = Doctor.new({"name" => input_doctor[0], "specialty" => input_doctor[1],  "insurance" => input_doctor[2]})
  new_doctor.save
  list_doctors
  main_menu
end

def list_doctors
  puts "Here is your list of doctors:"
  Doctor.all.each_with_index do |doctor, index|
    puts (index+1).to_s + ": " + doctor.name + ", " + doctor.specialty + ", " + doctor.insurance
  end
end

def delete_doctor
  list_doctors
  puts "Enter number of the doctor you want to delete"
  input_del = gets.chomp.to_i  - 1
  del_id = Doctor.all[input_del].id
  Doctor.delete(del_id)
  list_doctors
  main_menu
end

def list_patients
  puts "Here is your list of patients:"
  Patient.all.each_with_index do |pat, index|
    puts (index+1).to_s + ": " + pat.name + ", " + pat.insurance
  end
end

def add_patient
  list_patients
  puts "Enter a new patient in the following format: name|birthdate|insurance"
  input_patient = gets.chomp.split('|')
  new_patient = Patient.new({"name" => input_patient[0], "birthdate" => input_patient[1],  "insurance" => input_patient[2]})
  new_patient.save
  list_patients
  see_doctor(new_patient.id)
end

def delete_patient
  list_patients
  puts "Enter number of the patient you want to delete"
  input_del = gets.chomp.to_i - 1
  del_id = Patient.all[input_del].id
  Patient.delete(del_id)
  list_patients
  main_menu
end

def see_doctor
  list_patients
  puts "Choose your patient"
  input_patient = gets.chomp.to_i - 1
  patient = Patient.all[input_patient].id
  list_doctors
  puts "Enter number of doctor the patient will visit"
  input_doc = gets.chomp.to_i - 1
  doctor = Doctor.all[input_doc].id
  Doctor.patient_doctor_add(patient, doctor)
  puts "Doctor Added"
  main_menu
end

def doctor_patient_list
  list_doctors
  puts "Enter number of doctor to see their patient list"
  input_doc = gets.chomp.to_i - 1
  doc_id = Doctor.all[input_doc].id
  Doctor.patient_list(doc_id).each do |patient|
    puts patient
  end
  main_menu
end

main_menu
