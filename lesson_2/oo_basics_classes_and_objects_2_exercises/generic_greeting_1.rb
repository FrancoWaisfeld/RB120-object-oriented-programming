class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

kitty = Cat.new
Cat.generic_greeting
kitty.class.generic_greeting
