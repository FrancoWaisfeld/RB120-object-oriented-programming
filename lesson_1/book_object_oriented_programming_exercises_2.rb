class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  def grade
    @grade
  end
end

bob = Student.new('Bob', 52)
joseph = Student.new('Joseph', 99)

puts bob.better_grade_than?(joseph)
puts joseph.better_grade_than?(bob)
