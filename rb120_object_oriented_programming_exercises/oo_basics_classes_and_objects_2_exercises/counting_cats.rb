class Cat
  @@cats_count = 0

  def initialize
    @@cats_count += 1
  end

  def self.total
    @@cats_count
  end
end

kitty1 = Cat.new
kitty2 = Cat.new

p Cat.total