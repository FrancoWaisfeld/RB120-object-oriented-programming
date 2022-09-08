class Person
  attr_accessor(:first_name, :last_name)

  def initialize(name_, last_name_='')
    @first_name = name_
    @last_name = last_name_
  end

  def name
    "#{first_name} #{last_name}"
  end

  def name=(full_name)
    self.first_name, self.last_name = full_name.split
  end

  def to_s
    name
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
