class Specialty

  attr_reader :name, :id

  def initialize(name)
    @name = name
    save
  end

  def save
    check = DB.exec("SELECT * FROM specialties WHERE name = '#{@name}';")
    if check.first == nil
      results = DB.exec("INSERT INTO specialties (name) VALUES ('#{@name}') RETURNING id;")
      @id = results.first['id'].to_i
    else
      @id = check.first['id'].to_i
    end
  end

  def self.delete(specialty_id)
    DB.exec("DELETE FROM specialties WHERE id = #{specialty_id};")
  end

  def ==(another_specialty)
    self.name == another_specialty.name
  end

end
