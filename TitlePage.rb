#!/usr/bin/ruby

require 'gtk3'
require './Board.rb'
require './Deck.rb'
require './Card.rb'
require './Rules.rb'

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
    override_background_color(Gtk::StateFlags::NORMAL, Gdk::RGBA.new(0.1,0.6,0.1,1.0))

    #Object that fixes other objects in the window
    fixed = Gtk::Fixed.new
    add fixed

    #Image for Calculation Solitaire
    image = Gtk::Image.new(:file => "./cardPics/text.png")
    fixed.put image, 75, 250

    #Button to close the game
    endGameButton = Gtk::Button.new :label =>'Close Game'
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

    #Button to show the rules
    ruleButton = Gtk::Button.new :label => 'Rules'
    ruleButton.set_size_request 80, 30
    fixed.put ruleButton, 500, 25
    ruleButton.signal_connect('clicked'){ #Button action
      window.destroy
      window = Rules.new
    }

    show_all
  end
end

window = TitlePage.new
Gtk.main