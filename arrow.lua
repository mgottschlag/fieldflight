Class = require "hump.class"
require "anal/AnAL"
vector = require "hump.vector"

Arrow = Class(function(self)
	self.v = vector(0,0)
	self.rotation = 0
	self.x = 300
	self.y = 300
end)

-- constant
local width = 200
local height = 200
local scale = 0.5
local arrow_polygon = {	50, 1,											--top point
				19, 13,  4, 37,  1, 54,  2, 91,  9, 110,  30, 133,  14, 145,  6, 162, 9, 281, 		--left side 
				89, 281,  92, 162,  85, 145,  68, 133,  89, 110,  97, 91,  98, 54,  95, 37,  80, 13} 	--right side}

function Arrow:init()
	self.image = love.graphics.newImage("graphics/Spaceship.png")
	self.arrow_animation = newAnimation(self.image, 100, 282, 0, 1)
	self.width = 100
	self.height = 282
	self.scale = 0.5
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


function Arrow:rotate(degree)
	self.rotation = math.mod(self.rotation - degree, 360)
end

function Arrow:scaleArrowPolygon()
	for x in self.spaceship_polygon do
		x = x*self.scale
	end
end

function Arrow:rotateArrowPolygon()
	rot_in_deg = math.rad(self.rotation)
	for i=1, # self.arrow_polygon, 2 do
  		self.arrow_polygon[i] 	= (math.cos(rot_in_deg)*self.arrow_polygon[i]) 
  			+ (-1*math.sin(rot_in_deg)*self.arrow_polygon[i+1])
  		self.arrow_polygon[i+1]	= (math.sin(rot_in_deg)*self.arrow_polygon[i]) 
  			+ (   math.cos(rot_in_deg)*self.arrow_polygon[i+1])
 	end
end