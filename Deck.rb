#!/usr/bin/ruby

require './Card.rb'
require 'gtk3'
class Deck < Gtk::Fixed
  
  def initialize
    super
    set_size_request(80 + 72, 96)
    @currentDeck = Array.new
    self.createDeck
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
      for j in 1...5
        card = Card.new i, j
        @currentDeck.push(card)
        puts "Putting " + card.to_s
        self.put(card, 0, 0)
        
        card.signal_connect("button_press_event") do |widget, event|
          if Gdk::EventType::BUTTON2_PRESS==event.event_type
            false
          end
          self.drawCard
        end
      end
    end
    @currentDeck.shuffle!
  end

  def drawCard
    puts "drawCard"
    card = @currentDeck.pop
    if card
      self.remove(card)
      card.flip_face_up
      self.put(card, 80, 0);
    end
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
