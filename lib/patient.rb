class Patient

  attr_reader :name, :birthdate, :insurance, :insurance_id, :id

  def initialize(attributes)
    @name = attributes['name']
    @birthdate = attributes['birthdate']
    @insurance = attributes['insurance']
    @id = attributes['id']
    add_insurance
  end

  def save
    results = DB.exec("INSERT INTO patients (name, birthdate, ins_id) VALUES ('#{name}', '#{birthdate}', #{insurance_id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def add_insurance
    new_insurance = Insurance.new(@insurance)
    @insurance_id = new_insurance.id
  end

  def self.all
    results = DB.exec("SELECT * FROM patients;")
    patients = []
    results.each do |result|
      name = result['name']
      birthdate = result['birthdate']
      insurance = self.insurance_match(result['ins_id'])
      id = result['id']
      patients << Patient.new({'name' => name, 'birthdate' => birthdate, 'insurance' => insurance, 'id' => id.to_i})
    end
    patients
  end

  def self.insurance_match(ins_id)
    results = DB.exec("SELECT * FROM insurance WHERE id = #{ins_id};")
    results.first['name']
  end

  def self.delete(patient_id)
    DB.exec("DELETE FROM patients WHERE id = #{patient_id};")
  end

  def ==(another_patient)
    self.id == another_patient.id
  end

end
