class Project
  attr_reader :id, :title

  def initialize(attributes)
    @title = attributes[:title]
    @id = attributes[:id]
  end

  def ==(project)
    @title == project.title
  end

  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def update(attributes)
    new_title = attributes[:title]
    if new_title
      @title = new_title
      DB.exec("UPDATE projects SET title = '#{new_title}' WHERE id = #{@id};")
    end
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id}")
  end

  def volunteers
    db_records = DB.exec("SELECT * FROM volunteers WHERE project_id = #{@id};")
    db_records.map { |db_record| Volunteer.new_from_db(db_record) }
  end

  def self.new_from_db(db_record)
    title = db_record.fetch("title")
    id = db_record.fetch("id").to_i
    Project.new({:title => title, :id => id})
  end

  def self.all
    db_records = DB.exec("SELECT * FROM projects")
    db_records.map { |db_record| Project.new_from_db(db_record) }
  end

  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
    if project
      title = project.fetch("title")
      Project.new({:title => title, :id => id})
    end
  end

end
