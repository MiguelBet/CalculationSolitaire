class Card
  # Suite legend: 1 = hearts, 2 = spades, 3 = diamonds, 4 = clubs
  # cardValue 11 = jack, 12 = queen, 13 = king
  @@cardValue = 0;
  @@cardSuit = 0;

  def initialize(value, suit)
    @cardValue = value
    @cardSuit = suit
  end

  def get_value
    @cardValue
  end

  def get_suit
    @cardSuit
  end

  def to_s
    suit = "";
    value = "";

    case @cardValue
      when 1
        value = "A"
      when 11
        value = "J"
      when 12
        value = "Q"
      when 13
        value = "K"
      else
        value = @cardValue.to_s
    end

    case @cardSuit
      when 1
        suit = "Hearts"
      when 2
        suit = "Spades"
      when 3
        suit = "Diamonds"
      when 4
        suit = "Clubs"
    end
    value + " of " + suit
  end
end