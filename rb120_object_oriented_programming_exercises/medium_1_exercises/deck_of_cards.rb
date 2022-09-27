class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @cards = []
    reset
  end

  def draw
    reset if @cards.empty?
    @cards.pop
  end

  private

  def reset
    populate_cards
    shuffle_cards
  end

  def populate_cards
    SUITS.each do |suit|
      RANKS.each do |rank|
        @cards << Card.new(rank, suit)
      end
    end
  end

  def shuffle_cards
    @cards.shuffle!
  end
end

class Card
  attr_reader :rank, :suit

  NUMERIC_RANK = {
    'Jack' => 11,
    'Queen' => 12,
    'King' => 13,
    'Ace' => 14
  }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def get_numeric_rank
    NUMERIC_RANK.fetch(rank, rank)
  end

  def ==(value2)
    (self.get_numeric_rank == value2.get_numeric_rank) &&
    (self.suit == value2.suit)
  end

  def <=>(value2)
    self.get_numeric_rank <=> value2.get_numeric_rank
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.
