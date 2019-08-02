class Project
  attr_reader :id
  attr_reader :title

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

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects")
    returned_projects.map do |project|
      title = project.fetch("title")
      id = project.fetch("id")
      Project.new({:title => title, :id => id})
    end
  end

  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
    if project
      title = project.fetch("title")
      Project.new({:title => title, :id => id})
    end
  end

end
