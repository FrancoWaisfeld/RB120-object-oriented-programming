class Move
  attr_reader :value

  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def initialize(value)
    @value = value
  end

  def scissors?
    value == 'scissors'
  end

  def paper?
    value == 'paper'
  end

  def rock?
    value == 'rock'
  end

  def spock?
    value == 'spock'
  end

  def lizard?
    value == 'lizard'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (rock? && other_move.lizard?) ||
      (paper? && other_move.rock?) ||
      (paper? && other_move.spock?) ||
      (scissors? && other_move.paper?) ||
      (scissors? && other_move.lizard?) ||
      (spock? && other_move.scissors?) ||
      (spock? && other_move.rock?) ||
      (lizard? && other_move.spock?) ||
      (lizard? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (rock? && other_move.spock?) ||
      (paper? && other_move.scissors?) ||
      (paper? && other_move.lizard?) ||
      (scissors? && other_move.rock?) ||
      (scissors? && other_move.spock?) ||
      (spock? && other_move.lizard?) ||
      (spock? && other_move.paper?) ||
      (lizard? && other_move.rock?) ||
      (lizard? && other_move.scissors?)
  end

  def to_s
    value
  end
end

class Player
  attr_reader :name
  attr_accessor :move, :score, :move_history

  def initialize
    @name = set_name
    @score = 0
    @move_history = []
  end
end

class Human < Player
  def set_name
    name_ = nil
    loop do
      puts "What is your name?"
      name_ = gets.chomp
      break unless name_.empty?
    end
    name_
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Invalid choice."
    end
    self.move = Move.new(choice)
    move_history << move
  end
end

class Computer < Player
  def set_name
    'Bot'
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
    move_history << move
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock."
    puts "First player to win 10 rounds wins!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Good bye!"
  end

  def increase_score(player)
    player.score = player.score + 1
  end

  def display_score
    puts "The score is #{human.name}: #{human.score} vs #{computer.name}: #{computer.score}."
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_match_winner
    if human.score > computer.score
      puts "#{human.name} won the game!"
    else
      puts "#{computer.name} won the game!"
    end
  end

  def display_round_winner
    if human.move > computer.move
      increase_score(human)
      puts "#{human.name} won this round!"
    elsif human.move < computer.move
      increase_score(computer)
      puts "#{computer.name} won this round!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil

    loop do
      puts "Would you like to play again? (y / n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Invalid input. Enter 'y' or 'n'."
    end

    return false if answer == 'n'
    return true if answer == 'y'
  end

  def display_move_history
    human.move_history.each_index do |index|
      puts "In round #{index + 1} #{human.name} picked #{human.move_history[index]} and #{computer.name} picked #{computer.move_history[index]}."
    end
  end

  def play
    display_welcome_message
    loop do
      loop do
        human.choose
        computer.choose
        display_moves
        display_round_winner
        display_score
        break if human.score >= 10 || computer.score >= 10
      end
      display_match_winner
      break unless play_again?
    end
    display_move_history
    display_goodbye_message
  end
end

RPSGame.new.play
