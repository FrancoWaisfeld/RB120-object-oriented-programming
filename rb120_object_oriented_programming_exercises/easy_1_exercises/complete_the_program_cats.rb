class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  attr_reader :name, :age, :fur_color

  def initialize(name, age, fur_color)
    @fur_color = fur_color
    super(name, age)
  end
  
  def to_s
    "My cat #{name} is #{age} years old and has #{fur_color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch
