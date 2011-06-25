Class = require "hump.class"
require "anal/AnAL"
vector = require "hump.vector"

Arrow = Class(function(self)
	self.v = vector(0,0)
	self.rotation = 0
end)

-- constant
local width = 200
local height = 200
local scale = 0.5
local spaceship
local level

function Arrow:init(spaceship, level)
	self.image = love.graphics.newImage("graphics/Arrow.png")
	self.arrow_animation = newAnimation(self.image, 100, 282, 0, 1)
	self.width = 100
	self.height = 282
	self.scale = 0.5
	self.spaceship = spaceship
	self.level = level
end

function Arrow:update()
	self:rotate()
end

function Arrow:draw()
	local x, y, width, height = love.graphics.getScissor( )
	self.arrow_animation:draw(x + width -100, y + 150,
		self.rotation / 180 * math.pi, self.scale, self.scale, 
		self.width / 2, self.height / 2)
end



function Arrow:rotate()
	local x = self.level.end_x - self.spaceship:getXPos()
	local y = self.level.end_y - self.spaceship:getYPos()
	self.rotation = math.atan2(x,y)
end

