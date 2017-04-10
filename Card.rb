#!/usr/bin/ruby

require './Card.rb'
require 'gtk3'

class Card < Gtk::EventBox
  # Suite legend: 1 = hearts, 2 = spades, 3 = diamonds, 4 = clubs
  # cardValue 11 = jack, 12 = queen, 13 = king

  def initialize value, suit
    super()
    #initial variable values
    @cardValue = value
    @cardSuit = suit
    @clicked = false
    @faceUp = false


    #image for behind card
    @image = Gtk::Image.new(:file => "./cardPics/b2fv.png")
    self.add(@image)

    #variables for dragging
    @dragging = false
    @draggable = false

    #to get card coordinates after click and hold
    self.signal_connect("button_press_event") do |widget, event|
      if event.button == 1 and @draggable
        parentX, parentY, _w, _h = parent.allocation.to_a #gets (x,y), width and height of parent container
        @x, @y, _w, _h = self.allocation.to_a #gets (x,y), width and height of this card
        @dragging = true #allows for dragging
        @drag_base_x = event.x_root #gets x value of mouse on screen
        @drag_base_y = event.y_root #gets y value of mouse on screen





          @drag_x = (parentX - @x).abs #determines difference in x coordinates of parent container and card
          @drag_y = (parentY - @y).abs #determines difference in y coordinates of parent container and card
          # force moved card to top of deck after single click
          p = self.parent
          p.remove(self)
          p.put(self, @drag_x, @drag_y)
      else
        false
      end
    end

    #to move a card after click and hold
    self.signal_connect("motion_notify_event") do |widget, event|
      if @dragging
        delta_x = event.x_root - @drag_base_x #x coordinate difference using the mouse coordinates and card coordinates
        delta_y = event.y_root - @drag_base_y #y coordinate difference using the mouse coordinates and card coordinates
        if delta_x != 0 and delta_y != 0
          self.parent.move(self, @drag_x + delta_x, @drag_y + delta_y) #moves the card
        else
          false
        end
      else
        false
      end
    end

    #TRYING TO MAKE THE CARD GO BACK TO THE DECK WHEN MOUSE LEAVES CARD
    self.signal_connect ("leave-notify-event") do |widget, event|
      if @dragging
          self.parent.move(self, @x, @y) #moves the card
        @dragging = false
      else
      end
    end

    #to make the card undraggable after click release
    self.signal_connect("button_release_event") do |widget, event|
      if event.button == 1
        @dragging = false
      else
        false
      end
    end
  end

  #getters/setters
  def set_draggable draggable
    @draggable = draggable
  end
  
  def get_draggable
    @draggable
  end
  
  def get_value
    @cardValue
  end

  def get_suit
    @cardSuit
  end

  #to flip the card
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

  #to print out value and suite to console
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