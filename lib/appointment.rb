class Appointment

  attr_reader :dp_id, :time, :cost, :id, :doctor, :patient

  def initialize(dp_id, time, cost, id=nil)
    @dp_id = dp_id
    @time = time
    @cost = cost
    @id = id
    check_doctor
    check_patient
  end

  def self.all
    results = DB.exec("SELECT * FROM appointments;")
    appointments = []
    results.each do |result|
      dp_id = result['dp_id']
      time = result["time"]
      cost = result["cost"].to_i
      id = result["id"].to_i
      appointments << Appointment.new(dp_id, time, cost, id)
    end
    appointments
  end

  def check_doctor
    results = DB.exec("SELECT * FROM doctors_patients WHERE id = #{dp_id};")
    doc_id = results.first['doctor_id']
    doctor_results = DB.exec("SELECT * FROM doctors WHERE id = #{doc_id};")
    @doctor = doctor_results.first['name']
  end

  def check_patient
    results = DB.exec("SELECT * FROM doctors_patients WHERE id = #{dp_id};")
    pat_id = results.first['patient_id']
    patient_results = DB.exec("SELECT * FROM patients WHERE id = #{pat_id};")
    @patient = patient_results.first['name']
  end

  def save
    results = DB.exec("INSERT INTO appointments (dp_id, time, cost) VALUES ('#{dp_id}', '#{time}', #{cost}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_appointment)
    self.id == another_appointment.id
  end
end
