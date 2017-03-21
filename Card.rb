class Card < Gtk::Image
  # Suite legend: 1 = hearts, 2 = spades, 3 = diamonds, 4 = clubs
  # cardValue 11 = jack, 12 = queen, 13 = king
  @@cardValue = 0;
  @@cardSuit = 0;

  def initialize x, y, value, suit, picture
    super(:file => picture)
    @x = x
    @y = y
    @cardValue = value
    @cardSuit = suit
    @clicked = false

  end

  def move x, y
    @x = x
    @y = y
  end
  def tryToMove x, y
    if @clicked
      @x += x
      @y += y
    end
  end
  def click? x, y
    if x > @x and x < @x + @xw and y > @y and y < @y + @yw
      @clicked = true
      return true
    else
      return false
    end
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