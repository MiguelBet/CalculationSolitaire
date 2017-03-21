#!/usr/bin/ruby

require 'gtk3'
require './Board.rb'
require './Deck.rb'
require './Card.rb'

class TitlePage < Gtk::Window
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
    set_window_position :center
    set_default_width 900
    set_default_height 600
    set_resizable false

    #Object that fixes other objects in the window
    fixed = Gtk::Fixed.new
    add fixed

    #Lable for calculation solitaire
    mainLable = Gtk::Label.new "Calculation Solitaire"
    fixed.put mainLable, 225, 70

    #Button to end the game
    endGameButton = Gtk::Button.new :label =>'End Game'
    endGameButton.set_size_request 80,30
    fixed.put endGameButton, 750, 25
    endGameButton.signal_connect('clicked'){   #Button Action
      Gtk.main_quit
    }

    #Button to start the game
    startGameBtn = Gtk::Button.new :label =>'Start Game'
    startGameBtn.set_size_request 80,30
    fixed.put startGameBtn, 600, 25
    startGameBtn.signal_connect('clicked'){   #Button Action
      window.destroy
      window = Board.new
    }

    show_all
  end
end

window = TitlePage.new
Gtk.main