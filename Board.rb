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
    
    blue = Gdk::Color.parse("#CFFCFF") #is this not used????

    
    #Required window attributes
    set_title "Calculation Solitaire"
    signal_connect "destroy" do
      Gtk.main_quit
    end
    set_default_width 900
    set_default_height 600
    set_resizable false
    set_window_position :center
    override_background_color(Gtk::StateFlags::NORMAL, Gdk::RGBA.new(0.1,0.6,0.1,1.0))

    #Object that fixes other objects in the window
    fixed = Gtk::Fixed.new
    add fixed

    #Button to return to title screen
    endGameButton = Gtk::Button.new :label =>'End Game'
    endGameButton.set_size_request 80,30
    fixed.put endGameButton, 750, 25
    endGameButton.signal_connect('clicked'){   #Button Action
      window.destroy
      window = TitlePage.new
    }

    #creates the deck
    deck = Deck.new
    fixed.put(deck, 100, 100)

    #creates the foundations
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

    #creates the waste
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
    
    cardRemovedFromDeck = false
    deck.getTopCard.signal_connect("button_press_event") do |widget, event|
      if event.button == 1 && !cardRemovedFromDeck
        cardRemovedFromDeck = true
        
        card = deck.drawCard
        if card.parent
          card.parent.remove(card)
        end
        card.flip_face_up
        card.set_draggable(true)
        fixed.put(card, 100 + 72 + 8,100); #on face-up deck
        
        handlerId = card.signal_connect("button_release_event") do |widget, event|
          puts "release2"
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
                  
                  # topCard = waste.getTopCard
                  # if topCard
                  #   topCard.set_draggable(false)
                  # end
                  puts "waste.addCard inside of drawing off of deck"
                  waste.addCard(card)
                  
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
              #put back on face-up deck slot
              fixed.put(card, 100 + 72 + 8, 100)
            else
              puts "successful move " + handlerId.to_s
              cardRemovedFromDeck = false
              card.signal_handler_disconnect(handlerId)
            end
          end
        end
      end
    end
    
    wastes.each do |waste|
      
      waste.getEventBox.signal_connect("button_press_event") do |wiget, event| #dragging off of waste onto foundation
        puts "eb1 " + waste1.getEventBox.to_s + " " + waste1.getEventBox.allocation.to_a.to_s
        puts "eb2 " + waste2.getEventBox.to_s + " " + waste2.getEventBox.allocation.to_a.to_s
        puts "eb3 " + waste3.getEventBox.to_s + " " + waste3.getEventBox.allocation.to_a.to_s
        puts "eb4 " + waste4.getEventBox.to_s + " " + waste4.getEventBox.allocation.to_a.to_s
        
        
        puts "signal2 " + wiget.to_s + " -> " + waste.to_s
        if event.button == 1
          puts "removeCard"
          card = waste.removeCard
          
          if card
            x, y, _w, _h = card.allocation.to_a
            fixed.put(card, x, y)
            waste.removeEventBox
            
            card.set_draggable(true)
            card.signal_emit("button_press_event", event)
            
            leaveHandlerId = nil
            handlerId = card.signal_connect("button_release_event") do |widget, event|
              if event.button == 1 and card.get_draggable
                card.signal_handler_disconnect(handlerId)
                card.signal_handler_disconnect(leaveHandlerId)
                waste.addEventBox
                cardX, cardY, _w, _h = card.allocation.to_a
                
                placed = false
                for foundation in foundations
                  x, y, w, h = foundation.allocation.to_a
                  h = 96
                  # puts "Trying foundation " + foundation.to_s + " (" + x.to_s + "," + y.to_s + ". " + w.to_s + "," + h.to_s + ")"
                  if (x - cardX).abs < w and (y - cardY).abs < h
                    # puts "Card has been dropped on foundation " + foundation.to_s
                    
                    fixed.remove(card)
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
                
                if !placed
                  puts "waste.addCard inside of pulling off waste"
                  waste.addCard(card)
                  card.set_draggable(false)
                else
                  puts "successful move"
                end
              end
            end
            
            leaveHandlerId = card.signal_connect("leave-notify-event") do |widget, event|
              card.signal_handler_disconnect(leaveHandlerId)
              card.signal_handler_disconnect(handlerId)
              waste.addCard(card)
              card.set_draggable(false)
            end
          end
        end
      end
    end

    show_all
  end
end
