class Volunteer
  attr_reader :id, :name, :project_id

  def initialize(attributes)
    @name = attributes[:name]
    @project_id = attributes[:project_id]
    @id = attributes[:id]
  end

  def ==(volunteer)
    @name == volunteer.name
  end

  def save
    if !@id
      result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
      @id = result.first().fetch("id").to_i
    end
  end

  def update(attributes)
    new_name = attributes[:name]
    if new_name
      @name = new_name
      DB.exec("UPDATE volunteers SET name = '#{new_name}' WHERE id = #{@id};")
    end
    new_project_id = attributes[:project_id]
    if new_project_id
      @project_id = new_project_id
      DB.exec("UPDATE volunteers SET project_id = '#{new_project_id}' WHERE id = #{@id};")
    end
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{@id}")
  end

  def self.new_from_db(db_record)
    name = db_record.fetch("name")
    project_id = db_record.fetch("project_id")
    id = db_record.fetch("id")
    Volunteer.new({:name => name, :project_id => project_id, :id => id})
  end

  def self.all
    db_records = DB.exec("SELECT * FROM volunteers")
    db_records.map { |db_record| Volunteer.new_from_db(db_record) }
  end

  def self.find(id)
    db_record = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
    if db_record
      Volunteer.new_from_db(db_record)
    end
  end
end
