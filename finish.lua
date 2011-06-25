Class = require "hump.class"
require "anal/AnAL"
vector = require "hump.vector"
Hardon = require "hardoncollider"

Finish = Class(function(self)
	self.hit =0 
	self.img = love.graphics.newImage("graphics/Arrow.png") 
	self.animation = newAnimation(self.img,64, 64, 0, 0) --self.hit)
	self.shape = HC.addCircle(100, 100, 50)
end)


function Finish:hit()
	self.hit = 2
end

function Finish:initialize()
	self.hit = 1
	print("blubb")
end

function Finish:draw(x, y)
	print(x, y)
	self.shape:moveTo(x, y)
	if self.hit ~= 0 then
		self.animation:draw(250,250)
	end
end
