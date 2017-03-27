#!/usr/bin/ruby

require 'gtk3'
class Rules < Gtk::Window
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
    image = Gtk::Image.new(:file => "./cardPics/rules.png")
    fixed.put image, 0, 0

    #Button to return to title page
    startGameBtn = Gtk::Button.new :label =>'Return'
    startGameBtn.set_size_request 80,30
    fixed.put startGameBtn, 600, 25
    startGameBtn.signal_connect('clicked'){   #Button Action
      window.destroy
      window = TitlePage.new
    }

    show_all

  end
end