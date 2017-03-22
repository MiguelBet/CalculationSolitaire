#!/usr/bin/ruby

require 'gtk3'
require 'rubygems'
require './Deck.rb'
require './Card.rb'
require './FoundationPile.rb'

class Board < Gtk::Window

  def initialize
    super
    init_ui
  end

  def init_ui
    @running == true

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

    #Lable for calculation solitaire
    mainLable = Gtk::Label.new "Game Board"
    fixed.put mainLable, 250, 50

    #Button to end the game
    endGameButton = Gtk::Button.new :label =>'End Game'
    endGameButton.set_size_request 80,30
    fixed.put endGameButton, 750, 25
    endGameButton.signal_connect('clicked'){   #Button Action
      Gtk.main_quit
    }

    #creates the deck
    deck = Deck.new
    #deck.createDeck



    foundation1 = FoundationPile.new 1, deck.findAndRemoveCard(1)
    foundation1.to_s
    fixed.put foundation1.topCard, 400, 100
    foundation2 = FoundationPile.new 2, deck.findAndRemoveCard(2)
    foundation2.to_s
    fixed.put foundation2.topCard, 500, 100
    foundation3 = FoundationPile.new 3, deck.findAndRemoveCard(3)
    foundation3.to_s
    fixed.put foundation3.topCard, 600, 100
    foundation4 = FoundationPile.new 4, deck.findAndRemoveCard(4)
    foundation4.to_s
    fixed.put foundation4.topCard, 700, 100

    topCard = deck.drawCard
    fixed.put topCard, 180, 100
    topOfDeck = Card.new 15, 15
    fixed.put topOfDeck, 100, 100
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
