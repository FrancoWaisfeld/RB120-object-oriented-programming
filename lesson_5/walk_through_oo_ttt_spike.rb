class Board
  attr_reader :squares

  WINNING_LINES = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9],
    [1, 5, 9], [3, 5, 7]
  ]

  def initialize
    @squares = {}
    reset
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      if three_identical_markers?(@squares.values_at(*line))
        return @squares.values_at(*line).sample.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  private

  def three_identical_markers?(squares)
    return false if squares.any?(&:unmarked?)
    squares.map(&:marker).all?(squares.sample.marker)
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_TO_MOVE = HUMAN_MARKER
  ROUNDS = 5

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
    @score = { @human => 0, computer => 0 }
  end

  def play
    clear
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  def joinor(arr, delimeter = ', ', seperator = 'or')
    case arr.size
    when 0 then ''
    when 1 then arr.first
    when 2 then arr.join(" #{seperator} ")
    else
      "#{arr[0..-2].join(delimeter)} #{seperator} #{arr.last}"
    end
  end

  def player_move
    loop do
      current_marker_moves
      break if board.full? || board.someone_won?
      clear_screen_and_display_board
    end
  end

  def single_game
    loop do
      display_score
      display_board
      player_move
      display_round_result unless game_winner?
      update_score
      break if game_winner?
      reset
    end
  end

  def main_game
    loop do
      single_game
      display_game_result
      break unless play_again?
      reset_match
      display_play_again_message
    end
  end

  def reset_match
    reset
    reset_score
  end

  def reset_score
    @score = { @human => 0, computer => 0 }
  end

  def game_winner?
    @score.values.any? { |num| num >= ROUNDS }
  end

  def display_game_result
    clear
    display_score
    if @score[human] == ROUNDS
      puts "You win the match!"
    else
      puts "Computer wins the match!"
    end
    puts ''
  end

  def display_score
    puts "Player has won #{@score[human]} rounds.\
 Computer has won #{@score[computer]} rounds."
    puts ''
  end

  def update_score
    case board.winning_marker
    when HUMAN_MARKER
      @score[human] += 1
    when COMPUTER_MARKER
      @score[computer] += 1
    end
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
    puts "First to #{ROUNDS} rounds wins."
    puts ""
  end

  def display_goodbye_message
    clear
    puts "Thanks for playing Tic Tac Toe! Goodbye."
  end

  def display_board
    puts "You're an #{human.marker}. Computer is a #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def current_marker_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def human_moves
    puts "Chose a square (#{joinor(board.unmarked_keys)})"
    # puts "Chose a square (#{board.unmarked_keys.join(', ')})"
    square = nil

    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Invalid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    board[find_best_move] = computer.marker
  end

  def find_best_move
    best_move = nil
    best_score = -1000

    (1..9).each do |space|
      if board.squares[space].marker == Square::INITIAL_MARKER
        board.squares[space].marker = computer.marker
        current_score = mini_max_algorithm(false, 0)
        board.squares[space].marker = Square::INITIAL_MARKER

        if current_score > best_score
          best_score = current_score
          best_move = space
        end
      end
    end
    best_move
  end

  def mini_max_algorithm(computer_turn, depth)
    depth += 1

    return 10 - depth if board.winning_marker == computer.marker
    return -10 - depth if board.winning_marker == human.marker
    return 0 - depth if board.full?

    if computer_turn
      max_algorithm(computer_turn, depth)
    else
      min_algorithm(computer_turn, depth)
    end
  end

  def max_algorithm(computer_turn, depth)
    best_score = -1000

    (1..9).each do |space|
      if board.squares[space].marker == Square::INITIAL_MARKER
        board.squares[space].marker = computer.marker
        current_score = mini_max_algorithm(!computer_turn, depth)
        board.squares[space].marker = Square::INITIAL_MARKER

        if current_score > best_score
          best_score = current_score
        end
      end
    end
    best_score
  end

  def min_algorithm(computer_turn, depth)
    best_score = 1000

    (1..9).each do |space|
      if board.squares[space].marker == Square::INITIAL_MARKER
        board.squares[space].marker = human.marker
        current_score = mini_max_algorithm(!computer_turn, depth)
        board.squares[space].marker = Square::INITIAL_MARKER

        if current_score < best_score
          best_score = current_score
        end
      end
    end
    best_score
  end

  def display_round_result
    clear_screen_and_display_board
    case board.winning_marker
    when HUMAN_MARKER
      puts "You won this round!"
    when COMPUTER_MARKER
      puts "Computer won this round!"
    else
      puts "This round tied!"
    end
    sleep 2
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y / n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Invalid input. Must be y or n."
    end

    answer == 'y'
  end

  def clear
    system 'clear'
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end
end

game = TTTGame.new
game.play
