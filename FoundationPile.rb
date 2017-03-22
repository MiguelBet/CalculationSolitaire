#!/usr/bin/ruby

require './Card.rb'
require 'gtk3'

class FoundationPile < Gtk::EventBox

  def initialize order, card
    super()
    @cardSequence = Array.new
    @cardsInPile = Array.new
    for i in 1...14
      @cardSequence.push((i*order))
    end
    for i in 1...4
      @cardSequence.map! { |x| x > 13 ? (x-13) : x}.flatten!
    end
    @cardsInPile.push card
    @cardsInPile[0].flip_face_up
    @cardSequence[0] = nil
    @cardSequence.compact!
  end

  def to_s
    puts @cardSequence.join(' ')
    puts @cardsInPile.join(' ')
  end
  def topCard
    return @cardsInPile.first()
  end
end