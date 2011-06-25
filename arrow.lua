Class = require "hump.class"
require "anal/AnAL"
vector = require "hump.vector"

Arrow = Class(function(self)
	self.v = vector(0,0)
	self.rotation = 0
	self.x = 500
	self.y = 50
end)

-- constant
local width = 200
local height = 200
local scale = 0.5
local spaceship


function Arrow:init(spaceship)
	self.image = love.graphics.newImage("graphics/Arrow.png")
	self.arrow_animation = newAnimation(self.image, 100, 282, 0, 1)
	self.width = 100
	self.height = 282
	self.scale = 0.5
	self.spaceship = spaceship
end

function Arrow:update(dt)
	self:calculatePosition(dt)
end

function Arrow:draw()
	self.arrow_animation:draw(self.x, self.y,
		self.rotation / 180 * math.pi, self.scale, self.scale, 
		self.width / 2, self.height / 2)
end

function Arrow:calculatePosition(dt)
	self.x = self.x - self.v.x * dt
	self.y = self.y - self.v.y * dt
end


function Arrow:rotate()
	self.rotation = math.mod(self.rotation - degree, 360)
end

