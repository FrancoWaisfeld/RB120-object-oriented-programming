class Participant
  attr_accessor :hand, :name

  def initialize
    @hand = []
    set_name
  end

  def busted?
    total > 21
  end

  def total
    sum = 0
    hand.each do |card|
      sum += if card.jack? || card.queen? || card.king?
               10
             elsif card.ace?
               11
             else
               card.value.to_i
             end
    end

    hand.select(&:ace?).count.times do
      break if sum <= 21
      sum -= 10
    end

    sum
  end

  def show_hand
    puts "---#{name}'s Hand---"
    hand.each do |card|
      puts "=> #{card}"
    end
    puts "=> Total: #{total}"
  end
end

class Player < Participant
  def set_name
    name = ''
    loop do
      puts "What is your name?"
      name = gets.chomp
      break unless name.empty?
    end
    self.name = name
  end
end

class Dealer < Participant
  def set_name
    self.name = "Dealer"
  end

  def show_flop
    puts "---#{name}'s Hand---"
    puts "=> #{hand.last}"
    puts "=> ?"
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    populate_cards
    cards.shuffle!
  end

  def populate_cards
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value|
        @cards << Card.new(value, suit)
      end
    end
  end

  def deal_card(person)
    person.hand << cards.pop
  end
end

class Card
  attr_reader :name

  VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  SUITS = ['H', 'S', 'C', 'D']

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def to_s
    "#{value} of #{suit}"
  end

  def suit
    case @suit
    when 'H' then 'Hearts'
    when 'S' then 'Spades'
    when 'C' then 'Clubs'
    when 'D' then 'Diamonds'
    end
  end

  def value
    case @value
    when 'J' then 'Jack'
    when 'Q' then 'Queen'
    when 'K' then 'King'
    when 'A' then 'Ace'
    else
      @value
    end
  end

  def ace?
    value == 'Ace'
  end

  def king?
    value == 'King'
  end

  def queen?
    value == 'Queen'
  end

  def jack?
    value == 'Jack'
  end
end

class TwentyOne
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @dealer = Dealer.new
    @player = Player.new
  end

  def display_welcome_message
    puts "Hello #{player.name}. Let's play twenty-one!"
  end

  def start
    loop do
      display_welcome_message
      deal_cards
      display_flop

      player_turn
      if player.busted?
        display_busted_message
        break
      end

      dealer_turn
      if dealer.busted?
        display_busted_message
        break
      end

      display_cards
      show_result
      break
    end
  end

  def deal_cards
    2.times do
      deck.deal_card(player)
      deck.deal_card(dealer)
    end
  end

  def display_flop
    player.show_hand
    puts ''
    dealer.show_flop
  end

  def display_cards
    puts ''
    player.show_hand
    puts ''
    dealer.show_hand
  end

  def player_turn
    puts ''
    puts "#{player.name}'s turn."
    loop do
      answer = hit_or_stay
      if answer == 'hit'
        puts "#{player.name} hits!"
        deck.deal_card(player)
        player.show_hand
        break if player.busted?
      else
        puts "#{player.name} stays!"
        break
      end
    end
  end

  def dealer_turn
    puts ''
    puts "#{dealer.name}'s turn"
    loop do
      dealer.show_hand
      if dealer.total >= 17
        puts "#{dealer.name} stays!"
        break
      else
        puts "#{dealer.name} hits!"
        deck.deal_card(dealer)
        break if dealer.busted?
      end
    end
  end

  def display_busted_message
    if player.busted?
      puts "#{player.name} busted... #{dealer.name} wins!"
    elsif dealer.busted?
      puts "#{dealer.name} busted... #{player.name} wins!"
    end
  end

  def hit_or_stay
    puts "Would you like to hit or stay?"
    answer = ''
    loop do
      answer = gets.chomp
      break if ['hit', 'stay'].include?(answer)
      puts "Invalid input. Enter 'hit' or 'stay'."
    end
    answer
  end

  def show_result
    puts ''
    if player.total > dealer.total
      puts "#{player.name} wins!"
    elsif player.total < dealer.total
      puts "#{dealer.name} wins!"
    else
      puts "#{player.name} and #{dealer.name} tied."
    end
  end
end

TwentyOne.new.start
