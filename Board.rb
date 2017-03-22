#!/usr/bin/ruby

require 'gtk3'
require 'rubygems'
require './Deck.rb'
require './Card.rb'
require './FoundationPile.rb'
require './WastePile.rb'

class Board < Gtk::Window

  def initialize
    super
    init_ui
  end

  def init_ui
    @running == true
    
    blue = Gdk::Color.parse("#CFFCFF")
    override_background_color(Gtk::StateFlags::NORMAL, Gdk::RGBA.new(0.1,0.6,0.1,1.0))
    
    #Required window attributes
    set_title "Calculation Solitaire"
    signal_connect "destroy" do
      Gtk.main_quit
    end
    set_default_width 900
    set_default_height 600
    set_resizable false
    set_window_position :center

    #Object that fixes other objects in the window
    fixed = Gtk::Fixed.new
    add fixed

    #Button to end the game
    endGameButton = Gtk::Button.new :label =>'End Game'
    endGameButton.set_size_request 80,30
    fixed.put endGameButton, 750, 25
    endGameButton.signal_connect('clicked'){   #Button Action
      Gtk.main_quit
    }

    #creates the deck
    deck = Deck.new
    fixed.put(deck, 100, 100)
    
    deck.getTopCard.signal_connect("button_press_event") do |widget, event|
      if event.button == 1
        card = deck.drawCard
        card.flip_face_up
        fixed.put(card, 100 + 72 + 8,100);
      end
    end


    foundation1 = FoundationPile.new 1, deck.findAndRemoveCard(1)
    fixed.put foundation1, 400, 100
    
    foundation2 = FoundationPile.new 2, deck.findAndRemoveCard(2)
    fixed.put foundation2, 500, 100
    
    foundation3 = FoundationPile.new 3, deck.findAndRemoveCard(3)
    fixed.put foundation3, 600, 100
    
    foundation4 = FoundationPile.new 4, deck.findAndRemoveCard(4)
    fixed.put foundation4, 700, 100
    
    
    waste1 = WastePile.new
    fixed.put waste1, 400, 250
    
    waste2 = WastePile.new
    fixed.put waste2, 500, 250
    
    waste3 = WastePile.new
    fixed.put waste3, 600, 250
    
    waste4 = WastePile.new
    fixed.put waste4, 700, 250
    
    # topCard = deck.drawCard
    # fixed.put topCard, 180, 100
    # topOfDeck = Card.new 15, 15
    # fixed.put topOfDeck, 100, 100
=begin
    buildable = Gtk::Builder.new

    topOfDeck.signal_connect('button_press_event'){   #Button Action
      topCard = deck.drawCard

    }
    fixed.add_child buildable, topCard, Card
=end
    show_all
  end
end
