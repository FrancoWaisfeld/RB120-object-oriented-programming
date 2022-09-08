class Cat
  attr_reader(:name)
  
  def initialize(name_)
    @name = name_
  end

  def greet
    puts "Hello my name is #{name}!"
  end
end

kitty = Cat.new("Sophie")
kitty.greet
