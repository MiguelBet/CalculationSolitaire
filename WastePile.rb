#!/usr/bin/ruby

require './Card.rb'
require 'gtk3'
class WastePile < Gtk::Fixed
	def initialize
		super
		set_size_request(72, 96)
		
		@eventBox = Gtk::EventBox.new
		@eventBox.set_size_request(72, 96)
		self.put(@eventBox, 0, 0)
		
		@emptySpotImage = Gtk::Image.new(:file => "./cardPics/blank.png")
   		self.put(@emptySpotImage, 0, 0)
		
		@cards = Array.new
	end
	
	def addCard card
		puts "adding card " + card.to_s
		@cards.push(card)
		if card.parent
			card.parent.remove(card)
		end
		y = (@cards.length - 1) * 20
		self.put(card, 0, y)
		
		self.removeEventBox
		self.addEventBox
		
		puts self.to_s + "@cards.length: " + @cards.length.to_s
	end
	
	def removeCard
		puts self.to_s + " @cards.length: " + @cards.length.to_s
		card = @cards.pop
		if card
			puts "removing card " + card.to_s
			self.remove(card)
			card
		else
			false
		end
	end
	
	def getTopCard
		@cards.last
	end
	
	def getEventBox
		@eventBox
	end
	
	def removeEventBox
		self.remove(@eventBox)
	end
	
	def addEventBox
		y = (@cards.length - 1) * 20
		self.put(@eventBox, 0, y)
	end
end