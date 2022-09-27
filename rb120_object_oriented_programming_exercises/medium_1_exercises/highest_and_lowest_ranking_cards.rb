class Card
  attr_reader :rank, :suit

  NUMERIC_RANK = {
    'Jack' => 11,
    'Queen' => 12,
    'King' => 13,
    'Ace' => 14
  }

  SUIT_RANK = {
    'Spades' => 4,
    'Hearts' => 3,
    'Clubs' => 2,
    'Diamonds' => 1
  }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def get_suit_rank
    SUIT_RANK.fetch(suit)
  end

  def get_numeric_rank
    NUMERIC_RANK.fetch(rank, rank)
  end

  def ==(value2)
    (self.get_numeric_rank == value2.get_numeric_rank) &&
      (self.suit == value2.suit)
  end

  def equal_rank?(value2)
    (self.get_numeric_rank <=> value2.get_numeric_rank) == 0
  end

  def <=>(value2)
    if equal_rank?(value2)
      self.get_suit_rank <=> value2.get_suit_rank
    else
      self.get_numeric_rank <=> value2.get_numeric_rank
    end
  end
end

cards = [
  Card.new(2, 'Hearts'),
  Card.new(10, 'Diamonds'),
  Card.new('Ace', 'Clubs')
]

puts cards
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [
  Card.new(4, 'Hearts'),
  Card.new(4, 'Diamonds'),
  Card.new(10, 'Clubs')
]
puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [
  Card.new(7, 'Diamonds'),
  Card.new('Jack', 'Diamonds'),
  Card.new('Jack', 'Spades')
]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [
  Card.new(8, 'Diamonds'),
  Card.new(8, 'Clubs'),
  Card.new(8, 'Spades')
]
puts cards.min.rank == 8
puts cards.max.rank == 8

cards = [
  Card.new('Ace', 'Clubs'),
  Card.new('Ace', 'Diamonds'),
  Card.new('Ace', 'Spades'),
  Card.new('Ace', 'Hearts')
]

p cards.sort
