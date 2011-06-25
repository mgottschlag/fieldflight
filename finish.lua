Class = require "hump.class"
require "anal/AnAL"
vector = require "hump.vector"
Hardon = require "hardoncollider"

Finish = Class(function(self)
	self.hit = 1
end)

function Finish:hit()
	self.hit = 2
end

function Finish:initialize()
	self.hit = 1
end

function Finish:draw()
	self.animation = newAnimation(
		love.graphics.newImage("graphics/finishline.png"),
		200, 200, 0, self.hit)
end
