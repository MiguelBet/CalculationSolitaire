#!/usr/bin/ruby

require './Card.rb'
class Deck
  def initialize
    @currentDeck = Array.new
  end

  def createDeck
    for i in 1...5
      for j in 1...14
        card = Card.new(j,i)
        @currentDeck.push(card)
      end
    end
    @currentDeck.shuffle!
  end

  def drawCard
    @currentDeck.pop
  end
end

#d = Deck.new
#d.createDeck
#puts d.drawCard.to_s
#puts d.drawCard.to_s