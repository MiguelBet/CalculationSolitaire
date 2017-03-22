#!/usr/bin/ruby

require 'gtk3'
require 'rubygems'
require './Deck.rb'
require './Card.rb'

class Board < Gtk::Window
  @@topCard

  def initialize
    super
    init_ui
  end

  def init_ui
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
    mainLable = Gtk::Label.new "Board"
    fixed.put mainLable, 300, 80

    #Button to end the game
    endGameButton = Gtk::Button.new :label =>'End Game'
    endGameButton.set_size_request 80,30
    fixed.put endGameButton, 750, 25
    endGameButton.signal_connect('clicked'){   #Button Action
      Gtk.main_quit
    }

    #creates the deck
    deck = Deck.new
    fixed.put deck, 100, 100
    
    show_all
  end
end
