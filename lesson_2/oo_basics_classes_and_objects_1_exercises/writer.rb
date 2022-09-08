class Cat
  attr_reader(:name)
  attr_writer(:name)
  
  def initialize(name_)
    @name = name_
  end

  def greet
    puts "Hello my name is #{name}!"
  end
end

kitty = Cat.new("Sophie")
kitty.greet

kitty.name = "Luna"
kitty.greet
