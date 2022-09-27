class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

garfield = AngryCat.new(9, "Garfield")
lucy = AngryCat.new(2, "Lucy")

garfield.name
garfield.age

lucy.name
lucy.age
