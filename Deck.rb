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
    for i in 1...14
      for j in 1...5
        card = Card.new i, j
        @currentDeck.push(card)
        #puts "Putting " + card.to_s


        #self.put(card, 100, 100)

=begin
        card.signal_connect("button_press_event") do |widget, event|
          if Gdk::EventType::BUTTON_PRESS==event.event_type
            false
          end
          self.drawCard
        end
=end


      end
    end
    @currentDeck.shuffle!
  end

  def drawCard
    #puts "drawCard"
    card = @currentDeck.first()
    if card
      #self.remove(card)
      card.flip_face_up
      #self.put(card, 180, 100);
    end
    return card
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
        return cardToSend
      end
    end
      puts "No card of this value"
  end

end
