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
    
    foundations = Array.new
    
    foundation1 = FoundationPile.new 1, deck.findAndRemoveCard(1)
    fixed.put foundation1, 400, 100
    foundations.push(foundation1)
    
    foundation2 = FoundationPile.new 2, deck.findAndRemoveCard(2)
    fixed.put foundation2, 500, 100
    foundations.push(foundation2)
    
    foundation3 = FoundationPile.new 3, deck.findAndRemoveCard(3)
    fixed.put foundation3, 600, 100
    foundations.push(foundation3)
    
    foundation4 = FoundationPile.new 4, deck.findAndRemoveCard(4)
    fixed.put foundation4, 700, 100
    foundations.push(foundation4)
    
    wastes = Array.new
    
    waste1 = WastePile.new
    fixed.put waste1, 400, 250
    wastes.push(waste1)
    
    waste2 = WastePile.new
    fixed.put waste2, 500, 250
    wastes.push(waste2)
    
    waste3 = WastePile.new
    fixed.put waste3, 600, 250
    wastes.push(waste3)
    
    waste4 = WastePile.new
    fixed.put waste4, 700, 250
    wastes.push(waste4)
    
    
    deck.getTopCard.signal_connect("button_press_event") do |widget, event|
      if event.button == 1
        card = deck.drawCard
        if card.parent
          card.parent.remove(card)
        end
        card.flip_face_up
        card.set_draggable(true)
        fixed.put(card, 100 + 72 + 8,100);
        
        card.signal_connect("button_release_event") do |widget, event|
          if event.button == 1 and card.get_draggable
            cardX, cardY, _w, _h = card.allocation.to_a
            
            # puts "Card has been dropped at " + cardX.to_s + "," + cardY.to_s
            
            placed = false
            
            if !placed
              for foundation in foundations
                x, y, w, h = foundation.allocation.to_a
                h = 96
                # puts "Trying foundation " + foundation.to_s + " (" + x.to_s + "," + y.to_s + ". " + w.to_s + "," + h.to_s + ")"
                if (x - cardX).abs < w and (y - cardY).abs < h
                  # puts "Card has been dropped on foundation " + foundation.to_s
                  
                  p = card.parent
                  p.remove(card)
                  canMove = foundation.addCard(card)
                  if canMove
                    placed = true
                    card.set_draggable(false);
                    break
                  else
                    placed = false
                  end
                end
              end
            end
            
            if !placed
              for waste in wastes
                x, y, w, h = waste.allocation.to_a
                # puts "Trying waste " + waste.to_s + " (" + x.to_s + "," + y.to_s + ". " + w.to_s + "," + h.to_s + ")"
                if (x - cardX).abs < w and (y - cardY).abs < h
                  # puts "Card has been dropped on waste " + waste.to_s
                  
                  card.parent.move(card, x, y); # add waste pile depth
                  card.set_draggable(false);
                  
                  placed = true
                  break
                end
              end
            end
            
            if !placed
              # puts "Card has not been dropped on a waste or foundation"
              if card.parent
                card.parent.remove(card)
              end
              fixed.put(card, 100 + 72 + 8, 100)
            end
          end
        end
      end
    end
    
    
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
