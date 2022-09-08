module Freightable
  def freightable?(pounds)
    pounds <= 10_000
  end
end


class Vehicle
  @@vehicles = 0

  def self.vehicles_count
    @@vehicles
  end

  attr_accessor(:color, :speed)
  attr_reader(:model, :year)

  def initialize(user_year, user_color, user_model)
    @year = user_year
    @color = user_color
    @model = user_model
    @speed = 0
    @@vehicles += 1
  end

  def to_s
    "Your #{color} #{year} #{model} is going #{speed} mph."
  end

  def self.gas_mileage(miles, gallons)
    puts "#{miles / gallons} miles per gallon of gas."
  end

  def change_color(new_color)
    self.color = new_color
  end

  def speed_up(number)
    @speed += number
    puts "You push the gas and accelerate #{number} mph."
  end

  def brake(number)
    @speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end

  def current_speed
    puts "You are now going #{@speed} mph."
  end

  def shut_down
    @speed = 0
    puts "Let's park this bad boy!"
  end

  def display_age
    "Your vehicle is #{calculate_age} years old."
  end

  private

  def calculate_age
    Time.now.year - self.year
  end
end

class MyCar < Vehicle
  MAX_PASSENGERS = 8
end

class MyTruck < Vehicle
  MAX_PASSENGERS = 2

  include Freightable

  attr_accessor(:freight_weight)

  def to_s
    "Your #{color} #{year} #{model} is going #{speed} mph and carrying \
#{freight_weight} lbs."
  end

  def initialize(user_year, user_color, user_model, freight_weight)
    @freight_weight = freight_weight
    super(user_year, user_color, user_model)
  end
end

lexus = MyCar.new(1997, 'white', 'lexus IS 250',)
lexus.speed_up(20)
lexus.current_speed
lexus.brake(20)
lexus.current_speed
lexus.shut_down
lexus.current_speed
MyCar.gas_mileage(300, 12)
puts lexus
lexus.change_color('grey')
puts lexus.color
puts Vehicle.vehicles_count
big_ol = MyTruck.new(2021, 'white', 'Tesla-Semi', 5000)
puts big_ol.freightable?(5600)

puts '-' * 20
puts MyTruck.ancestors
puts '-' * 20
puts MyCar.ancestors
puts '-' * 20
puts Vehicle.ancestors

puts '-' * 20
puts big_ol.display_age
puts lexus.display_age
puts big_ol