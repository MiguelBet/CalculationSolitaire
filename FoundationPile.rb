#!/usr/bin/ruby

require './Card.rb'
require 'gtk3'

class FoundationPile < Gtk::Fixed

  def initialize order, card
    super()
    @cardsInPile = Array.new
    @currentSequence = 0
    
    @cardSequence = Array.new
    @sequenceLabels = Array.new
    
    i = order - 1
    pos = 0
    until i == 12 do
      @cardSequence.push(i + 1)
      
      label = Gtk::Label.new
      label.set_markup(self.valueToString(i + 1))
      label.set_justify(Gtk::Justification::CENTER)
      
      x = (pos * 14.4) % 72
      y = ((pos * 14.4) / 72).floor * 14.4
      if i == 9
        x -= 5
      end
      self.put(label, x + 2, y + 100)
      @sequenceLabels.push(label)
      
      i += order
      i = i % 13
      pos += 1
    end
    
    @cardSequence.push(12 + 1)
      
    label = Gtk::Label.new
    label.set_markup(self.valueToString(12 + 1))
    
    x = (12 * 14.4) % 72
    y = ((12 * 14.4) / 72).floor * 14.4
    
    self.put(label, x + 2, y + 100)
    @sequenceLabels.push(label)
    
    self.addCard(card)
  end

  def to_s
    puts @cardSequence.join(' ')
    puts @cardsInPile.join(' ')
  end
  
  def addCard card
    nextCardInSequence = @cardSequence.first;
    puts "nextCardInSequence = " + nextCardInSequence.to_s
    if card.get_value == nextCardInSequence
      label = @sequenceLabels[@currentSequence]
      # puts @currentSequence
      # puts @sequenceLabels
      # puts @label
      label.set_markup("<span foreground=\"red\">" + self.valueToString(nextCardInSequence) + "</span>")
      
      @cardSequence[0] = nil
      @cardSequence.compact!
      @cardsInPile.push(card)
      card.flip_face_up
      self.put(card, 0, 0)
    end
  end
  
  def valueToString value
    case value
      when 1
        return "A"
      when 11
        return "J"
      when 12
        return "Q"
      when 13
        return "K"
      else
        return value.to_s
    end
  end
end