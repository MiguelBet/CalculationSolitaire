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
        # Determining which file to pull
        file = "./cardPics/"
        file.concat i.to_s
        file.concat "_"
        if j == 1
          file.concat "hearts"
        elsif j == 2
          file.concat "spade"
        elsif j == 3
          file.concat "diamond"
        elsif j == 4
          file.concat "clubs"
        end
        file.concat ".png"


        #image = Gtk::Image.new :file => file
        card = Card.new 0, 0, i, j, file
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
    @currentDeck.each_index do |i|
      if @currentDeck[i].value == value
        card = @currentDeck[i]
        @currentDeck[i] = nil
        @currentDeck.compact!
        return card
      end
      puts "No card of this value"
    end
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
