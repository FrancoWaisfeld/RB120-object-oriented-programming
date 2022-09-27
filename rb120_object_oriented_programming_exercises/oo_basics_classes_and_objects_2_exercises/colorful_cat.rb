class Cat
  COLOR = 'purple'
  
  attr_reader(:name)

  def initialize(new_name)
    @name = new_name
  end

  def greet
    puts "Hello! My names is #{name} and I'm a #{COLOR} cat!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
