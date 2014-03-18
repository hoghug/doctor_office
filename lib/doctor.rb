class Doctor

  attr_reader :name, :id, :specialty, :insurance, :specialty_id, :insurance_id

  def initialize(attributes)
    @name = attributes['name']
    @specialty = attributes['specialty']
    @insurance = attributes['insurance']
    @id = attributes['id']
    add_specialty
    add_insurance
  end

  def self.all
    results = DB.exec("SELECT * FROM doctors;")
    doctors = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      specialty = self.match_specialty(result['specialty_id'].to_i)
      insurance = self.match_insurance(result['ins_id'].to_i)
      doctors << Doctor.new({'name' => name, 'specialty' => specialty, 'insurance' => insurance, 'id' => id})
    end
    doctors
  end

  def save
    results = DB.exec("INSERT INTO doctors (name, specialty_id, ins_id) VALUES ('#{name}', #{specialty_id}, #{insurance_id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def add_specialty
    new_specialty = Specialty.new(@specialty)
    @specialty_id = new_specialty.id
  end

  def add_insurance
    new_insurance = Insurance.new(@insurance)
    @insurance_id = new_insurance.id
  end

  def self.match_specialty(specialty_id)
    results = DB.exec("SELECT * FROM specialties WHERE id = #{specialty_id};")
    results.first['name']
  end

  def self.match_insurance(ins_id)
    results = DB.exec("SELECT * FROM insurance WHERE id = #{ins_id};")
    results.first['name']
  end

  def self.delete(doctor_id)
    DB.exec("DELETE FROM doctors WHERE id = #{doctor_id};")
  end

  def ==(another_doctor)
    self.id == another_doctor.id
  end
end
