class Pet
  attr_reader :name, :pet_type

  def initialize(pet_type, name)
    @pet_type = pet_type
    @name = name
  end
end

class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def number_of_pets
    @pets.count
  end

  def add_pet(pet)
    @pets << pet
  end
end

class Shelter
  def initialize
    @owners = {}
    @unadopted_pets = []
  end

  def adopt(owner, pet)
    @unadopted_pets.delete(pet) if @unadopted_pets.delete(pet)
    owner.add_pet(pet)
    @owners[owner.name] ||= owner
  end

  def print_adoptions
    @owners.each do |owner_name, owner|
      puts "#{owner.name} has adopted the follwing pets:"
      owner.pets.each { |pet| puts "a #{pet.pet_type} named #{pet.name}" }
      puts '-' * 50
    end
  end

  def add_pet_to_shelter(pet)
    @unadopted_pets << pet
  end

  def print_unadopted_pets
    puts "The Animal Shelter has the following unadopted pets:"
    @unadopted_pets.each { |pet| puts "a #{pet.pet_type} named #{pet.name}"}
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding = Pet.new('cat', 'Pudding')
darwin = Pet.new('bearded dragon', 'Darwin')
kennedy = Pet.new('dog', 'Kennedy')
sweetie = Pet.new('parakeet', 'Sweetie Pie')
molly = Pet.new('dog', 'Molly')
chester = Pet.new('fish', 'Chester')
skittles = Pet.new('hamster', 'Skittles')
asta = Pet.new('dog', 'Asta')
laddie = Pet.new('Dog', 'Laddie')
fluffy = Pet.new('cat', 'Fluffy')
kat = Pet.new('cat', 'Kat')
ben = Pet.new('cat', 'Ben')
chatterbox = Pet.new('parakeet', 'Chatterbox')
bluebell = Pet.new('parakeet', 'Bluebell')

franco = Owner.new('F Waisfeld')
phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.add_pet_to_shelter(butterscotch)
shelter.add_pet_to_shelter(pudding)
shelter.add_pet_to_shelter(darwin)
shelter.add_pet_to_shelter(kennedy)
shelter.add_pet_to_shelter(sweetie)
shelter.add_pet_to_shelter(molly)
shelter.add_pet_to_shelter(chester)
shelter.add_pet_to_shelter(skittles)
shelter.add_pet_to_shelter(asta)
shelter.add_pet_to_shelter(laddie)
shelter.add_pet_to_shelter(fluffy)
shelter.add_pet_to_shelter(kat)
shelter.add_pet_to_shelter(ben)
shelter.add_pet_to_shelter(chatterbox)
shelter.add_pet_to_shelter(bluebell)
puts '-' * 50
shelter.print_unadopted_pets
puts '-' * 50
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.adopt(franco, skittles)
shelter.print_adoptions
shelter.print_unadopted_pets
puts '-' * 50
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "#{franco.name} has #{franco.number_of_pets} adopted pets."
