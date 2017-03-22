class Card < Gtk::EventBox
  # Suite legend: 1 = hearts, 2 = spades, 3 = diamonds, 4 = clubs
  # cardValue 11 = jack, 12 = queen, 13 = king

  def initialize value, suit
    super()
    
    @cardValue = value
    @cardSuit = suit
    @clicked = false
    
    @faceUp = false
    @image = Gtk::Image.new(:file => "./cardPics/b2fv.png");
    self.add(@image);
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

  def get_value
    @cardValue
  end

  def get_suit
    @cardSuit
  end
  
  def flip_face_up
    file = "./cardPics/"
    file.concat @cardValue.to_s
    file.concat "_"
    if @cardSuit == 1
      file.concat "hearts"
    elsif @cardSuit == 2
      file.concat "spade"
    elsif @cardSuit == 3
      file.concat "diamond"
    elsif @cardSuit == 4
      file.concat "clubs"
    end
    file.concat ".png"
    @image.set_file(file)
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