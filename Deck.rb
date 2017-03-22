#!/usr/bin/ruby

require './Card.rb'
require 'gtk3'
class Deck

  def initialize
    @currentDeck = Array.new
    @x = 5
    @y = 10
    @surface = Gtk::Image.new :file => "./cardPics/b2fv.png"
    #@xw = @surface.width
    #@yw = @surface.height
    @clicked = false
    @empty = false
  end
  def click? x, y
    if x > @x and x < @x + @xw and y > @y and y < @y + @yw
      @cards.last.move @xs+4/2, @ys+4/2
      puts "Move card!"
      @empty = false
    end
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
    for i in 1...13
      for j in 1...4
        #image = Gtk::Image.new :file => file
        card = Card.new i, j
        @currentDeck.push(card)
      end
    end
    @currentDeck.shuffle!
  end

  def drawCard
    return @currentDeck.pop
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
        return cardToSend
      end
    end
      puts "No card of this value"
  end

  def draw screen
    if !@currentDeck.empty?
      @surface.blit screen, [@x, @y]
    end
    @space.blit screen, [@xs, @ys]
    if !@empty
      peek.draw screen
    end
  end
end
