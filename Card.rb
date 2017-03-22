#!/usr/bin/ruby

require './Card.rb'
require 'gtk3'

class Card < Gtk::EventBox
  # Suite legend: 1 = hearts, 2 = spades, 3 = diamonds, 4 = clubs
  # cardValue 11 = jack, 12 = queen, 13 = king

  def initialize value, suit
    super()
    
    @cardValue = value
    @cardSuit = suit
    @clicked = false
    @faceUp = false

    @image = Gtk::Image.new(:file => "./cardPics/b2fv.png")
    self.add(@image)
    
    @dragging = false
    @draggable = false
    
    self.signal_connect("button_press_event") do |widget, event|
      if event.button == 1 and @draggable
        parentX, parentY, _w, _h = parent.allocation.to_a
        x, y, _w, _h = self.allocation.to_a
        @dragging = true
        @drag_x = (parentX - x).abs
        @drag_y = (parentY - y).abs
        @drag_base_x = event.x_root
        @drag_base_y = event.y_root
        
        # force to top
        p = self.parent
        p.remove(self)
        p.put(self, @drag_x, @drag_y)
      else
        false
      end
    end
    
    self.signal_connect("motion_notify_event") do |widget, event|
      if @dragging
        delta_x = event.x_root - @drag_base_x
        delta_y = event.y_root - @drag_base_y
        if delta_x != 0 and delta_y != 0
          self.parent.move(self, @drag_x + delta_x, @drag_y + delta_y)
        else
          false
        end
      else
        false
      end
    end
    
    self.signal_connect("button_release_event") do |widget, event|
      if event.button == 1
        @dragging = false
      else
        false
      end
    end
  end
  
  def set_draggable draggable
    @draggable = draggable
  end
  
  def get_value
    @cardValue
  end

  def get_suit
    @cardSuit
  end
  
  def flip_face_up
    file = "./cardPics/"
    file.concat @cardValue.to_s
    file.concat "_"
    if @cardSuit == 1
      file.concat "hearts"
    elsif @cardSuit == 2
      file.concat "spade"
    elsif @cardSuit == 3
      file.concat "diamond"
    elsif @cardSuit == 4
      file.concat "clubs"
    end
    file.concat ".png"
    @image.set_file(file)
  end

  def to_s
    suit = "";
    value = "";

    case @cardValue
      when 1
        value = "A"
      when 11
        value = "J"
      when 12
        value = "Q"
      when 13
        value = "K"
      else
        value = @cardValue.to_s
    end

    case @cardSuit
      when 1
        suit = "Hearts"
      when 2
        suit = "Spades"
      when 3
        suit = "Diamonds"
      when 4
        suit = "Clubs"
    end
    value + " of " + suit
  end

end