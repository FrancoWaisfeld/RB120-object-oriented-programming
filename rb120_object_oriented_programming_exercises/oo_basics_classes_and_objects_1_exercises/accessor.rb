class Cat
  attr_accessor(:name)
  
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
