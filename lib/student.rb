class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  attr_reader :name, :grade, :id 

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = nil
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT
      )   
    SQL
#how come there is no semicolon at the end of this command?
    DB[:conn].execute(sql)
    sqlcolumns = <<-SQL
    ALTER TABLE students ADD grade TEXT
    SQL
    DB[:conn].execute(sqlcolumns)
  end
#how can we add multiple
  def self.drop_table
    sql = <<-SQL
    DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql =  <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?,?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0] #what's up with the zeros??  
  
  end

  #the 'student' here is a hash of data
  def create(student)
    #when you come back to this, make every attribute (key value in hash probably) a column
  end

end



