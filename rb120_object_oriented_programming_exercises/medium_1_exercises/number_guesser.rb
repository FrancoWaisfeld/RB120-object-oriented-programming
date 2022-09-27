class GuessingGame
  def initialize(low, high)
    @guesses_left = nil
    @answer = nil
    @guess = nil
    @guessing_range = (low..high).to_a
  end

  def play
    reset

    loop do
      display_guesses_remaining
      player_turn
      display_hint
      @guesses_left -= 1
      break if @guesses_left == 0 || correct_guess?
    end
    display_result
  end

  private

  def display_guesses_remaining
    puts "You have #{@guesses_left} guesses remaining."
  end

  def reset
    @guesses_left = Math.log2(@guessing_range.size).to_i + 1
    @answer = @guessing_range.sample
  end

  def player_turn
    loop do
      puts "Enter a number between #{@guessing_range.min} and\
 #{@guessing_range.max}: "
      @guess = gets.chomp.to_i
      break if @guessing_range.include?(@guess)
      puts "Invalid guess."
    end
  end

  def display_hint
    if @guess > @answer
      puts "Your guess is too high."
    elsif @guess == @answer
      puts "That's the number!"
    else
      puts "Your guess is too low."
    end
    puts ''
  end

  def correct_guess?
    @answer == @guess
  end

  def display_result
    if correct_guess?
      puts "You won!"
    else
      puts "You have no more guesses. You lost!"
    end
  end
end

game = GuessingGame.new(501, 1500)
game.play
