user_input = ""
pets = []

class Dog
  attr_reader :name, :breed
  def initialize(name, breed)
    @name = name
    @asleep = false
    @breed = breed
    @sex = (1 + rand(2)) == 1 ? "male" : "female"
    @adjective = (@sex == "male") ? "him" : "her"
    @noun = (@sex == "male") ? "his" : "her"
    @pronoun = (@sex == "male") ? "he" : "she"
    @hunger = 0
    @bathroom = 0
    @age = 0
    @is_adult = false
    puts "#{@name.capitalize} is born as a #{@sex} #{@breed}."
  end

  def playFetch
    puts "You take #{@name.capitalize} outside to play some fetch. #{@pronoun.capitalize} wags #{@noun} tail in excitment!"
    passTime
  end

  def putToBed
    puts "You gently put #{@name.capitalize} to sleep on their sleeping mat. #{@pronoun.capitalize} quietly drifts into a long sleep."
    @asleep = true
    3.times do
      if @asleep
        passTime
        if @asleep
          puts "You can hear #{@name.capitalize} snoring quietly from another room."
        end
      end
    end
    if @asleep
      @asleep = false
      puts "#{@name.capitalize} wakes up slowly..."
    end
  end

  def bathe
    puts "You take #{@name.capitalize} to the bathroom and bathe #{@adjective}."
    passTime
  end

  def takeOutside
    puts "You take #{@name.capitalize} outside to use the bathroom."
    @bathroom = 0
    passTime
    @bathroom = 0
  end

  def feed
    puts "You give #{@name.capitalize} some food, #{@pronoun} quickly demolishes all of the food you gave #{@adjective}!"
    @hunger = 0
    passTime
    @hunger = 0
  end

  private

  def hungry?
    @hunger >= 7
  end

  def poopy?
    @bathroom >= 5
  end

  def passTime
    @hunger += 1
    @bathroom += 1
    @age += 1
    if @hunger == 20
      if @asleep
        puts "#{@name.capitalize} doesn't seem to be waking up...you think #{@adjective} may have died from starvation!"
        exit
      end
      puts "#{@name.capitalize} whines in pain and begins to convulse from starvation, #{@pronoun} falls over dead!"
      exit
    elsif @hunger == 10
      if @asleep
        @asleep = false
        puts "#{@name.capitalize} suddenly wakes up and whines..."
      end
      puts "#{@name.capitalize} suddenly bites you since you haven't feed #{@adjective}!"
    end

    if hungry?
      if @asleep
        @asleep = false
        puts "#{@name.capitalize} wakes up suddenly!"
      end
      puts "#{@name.capitalize}\'s stomach grumbles..."
    end

    if poopy?
      if @asleep
        @asleep = false
        puts "#{@name.capitalize} wakes up suddenly!"
      end
      puts "#{@name.capitalize} does the potty dance..."
    end

    if @age >= 50 and @is_adult == false
      @is_adult = true
      puts "#{@name.capitalize} has fully grown into an adult #{@breed}!"
    end
  end
end

def listPets(array)
  array.each do |pet|
    puts "#{pet.name.capitalize} the #{pet.breed.capitalize}."
  end
end

def createPet(pets)
  user_input = ""
  while user_input != "yes"
    puts "Enter the name of your new dog: "
    name = gets.chomp.downcase
    if name == "end"
      break
    end
    pets.each do |pet|
      while pet.name.downcase == name
        puts "You already have a pet with that name, please try a different name: "
        name = gets.chomp.downcase
      end
    end
    puts "Enter the breed of your new dog: "
    breed = gets.chomp.downcase
    if breed == "end"
      break
    end
    puts "Your new dog will be a #{breed.capitalize} named #{name.capitalize}. If this is correct then type yes, if not then type anything else."
    user_input = gets.chomp.downcase
  end
  if user_input == "yes"
    Dog.new(name, breed)
  end
end

def playWith(pet)
  user_input = ""
  puts "You are now interacting with #{pet.name.capitalize}, what would you like do with them, type help for more commands: "
  while user_input != "end"
    user_input = gets.chomp.downcase
    if user_input == "help"
      puts "Command List:".center(100)
      puts "Command:".ljust(50) + "Description:".rjust(50)
      puts "play fetch".ljust(50) + "Play fetch with #{pet.name.capitalize}.".rjust(50)
      puts "bed time".ljust(50) + "Put #{pet.name.capitalize} to sleep for the night.".rjust(50)
      puts "potty time".ljust(50) + "Take #{pet.name.capitalize} out to use the bathroom.".rjust(50)
      puts "feed".ljust(50) + "Feed #{pet.name.capitalize} some delicous dog food.".rjust(50)
      puts "bathe".ljust(50) + "Clean #{pet.name.capitalize} in the bath tub.".rjust(50)
      puts "end".ljust(50) + "Takes you back to the previous menu.".rjust(50)
    end
    if user_input == "play fetch"
      pet.playFetch
    elsif user_input == "bed time"
      pet.putToBed
    elsif user_input == "potty time"
      pet.takeOutside
    elsif user_input == "feed"
      pet.feed
    elsif user_input == "bathe"
      pet.bathe
    end
  end
end

while user_input != "end"
  puts "Enter a command or type help to see the list of commands: "
  user_input = gets.chomp.downcase
  if user_input == "help"
    puts "Command List:".center(100)
    puts "Command:".ljust(50) + "Description:".rjust(50)
    puts "create pet".ljust(50) + "Creates a new dog pet.".rjust(50)
    puts "end".ljust(50) + "Closes the program.".rjust(50)
    puts "\"your pets name\"".ljust(50) + "Allows you to interact with this pet.".rjust(50)
    puts "pet list".ljust(50) + "Shows a list of all of your current pets.".rjust(50)
  end
  if user_input == "create pet"
    pets << createPet(pets)
    playWith(pets[pets.length - 1])
  elsif user_input == "pet list"
    listPets(pets)
  elsif user_input == "end"
    exit
  else
    pets.each do |pet|
      if user_input == pet.name.downcase
        playWith(pet)
      else
        puts "That does not seem to be the name of one of your pets, try again."
      end
    end
  end
end
