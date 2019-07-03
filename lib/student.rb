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
  def self.create(student)
  #  binding.pry
    # student.each {|k,v| DB[:conn].execute("ALTER TABLE students ADD IF NOT EXISTS #{k} TEXT")  }# OK, this would ahve been cool but looking at the hash, it's not even needed. 
    #when you come back to this, make every attribute (key value in hash probably) a column
    # sql = "INSERT INTO students (name, grade) VALUES(?,?)"
    # student.map {|k,v| DB[:conn].execute("INSERT INTO students (#{k}) VALUES(?)", v)}
    #the reason the previous two lines are wrong is that they create a new row for each value in the hash -- crete a single student first and add them as one row instead
    new_kid = Student.new(student[:name], student[:grade])
    new_kid.save
    new_kid
  end



end



