class Insurance

  attr_reader :name, :id

  def initialize(name)
    @name = name
    save
  end

  def save
    check = DB.exec("SELECT * FROM insurance WHERE name = '#{name}';")
    if check.first == nil
      results = DB.exec("INSERT INTO insurance (name) VALUES ('#{@name}') RETURNING id;")
      @id = results.first['id'].to_i
    else
      @id = check.first['id'].to_i
    end
  end

  def ==(another_insurance)
    self.name == another_insurance.name
  end

end
