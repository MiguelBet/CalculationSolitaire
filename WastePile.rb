#!/usr/bin/ruby

require './Card.rb'
require 'gtk3'
class WastePile < Gtk::Fixed
	
	def initialize
		super
		set_size_request(72, 96)
		@emptySpotImage = Gtk::Image.new(:file => "./cardPics/blank.png")
   		self.put(@emptySpotImage, 0, 0)
	end
end