#!/usr/bin/ruby

require './Card.rb'
require 'gtk3'
class Deck < Gtk::Fixed
  
  def initialize
    super
    set_size_request(72, 96)
    
    self.createDeck
    
    @topCard = Card.new(0,0)
    self.put(@topCard, 0, 0)
    
    @emptySpotImage = Gtk::Image.new(:file => "./cardPics/blank.png")
    self.put(@emptySpotImage, 72 + 8, 0)
  end
  
  def getTopCard
    @topCard
  end
  
  def pop
    @empty = true
    #return @cards.last
    return @cards.pop
  end

  def push card
    @cards.push card
    if @empty == true
      @empty = false
      @cards.last.move @xs+4/2, @ys+4/2
    end

  end
  
  def createDeck
    @currentDeck = Array.new
    for i in 1...14
      for j in 1...5
        card = Card.new i, j
        @currentDeck.push(card)
        card.set_draggable(false)
        self.add(card)
      end
    end
    @currentDeck.shuffle!
  end

  def drawCard
    card = @currentDeck.pop
    self.remove(card)
    card
  end

  def nextCard
    card = @currentDeck[1]
    @currentDeck[@currentDeck.length] = @currentDeck[0]
    @currentDeck[0] = nil
    @currentDeck.compact!
    if card
      card.flip_face_up
    end
    return card
  end

  def pushCard card
    @cards.push card
    if @empty == true
      @empty = false
      #@cards.last.move @xs+4/2, @ys+4/2
    end
  end

  def findAndRemoveCard value

    for i in 1...@currentDeck.length
      if @currentDeck[i].get_value == value
        cardToSend = @currentDeck[i]
        @currentDeck[i] = nil
        @currentDeck.compact!
        self.remove(cardToSend)
        return cardToSend
      end
    end
      puts "No card of this value"
  end

end
