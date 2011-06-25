Class = require "hump.class"
require "anal/AnAL"
vector = require "hump.vector"

Spaceship = Class(function(self)
	self.v = vector(0,0)
	self.rotation = 0
	self.polarisation = 0
	self.x = 0
	self.y = 0
	self.startX = 0
	self.startY = 0
	--self.initialized --TODO weg!

	--self.image
	--self.player
	--self.spaceship_animation
end)

-- constant
local width = 200
local height = 200
local scale = 0.5
local spaceship_polygon = {	50, 1,											--top point
				19, 13,  4, 37,  1, 54,  2, 91,  9, 110,  30, 133,  14, 145,  6, 162, 9, 281, 		--left side 
				89, 281,  92, 162,  85, 145,  68, 133,  89, 110,  97, 91,  98, 54,  95, 37,  80, 13} 	--right side}

function Spaceship:countdown( player, img_path, x, y )
--TODO startrichtung muss von level abhängig sein
	self.startX = x
	self.startY = y
	self.image = love.graphics.newImage(img_path)
	self.spaceship_animation = newAnimation(self.image, 100, 282, 0, 1)
	self:backToTheRoots()
	self.player = player
	self.width = 100
	self.height = 282
	self.scale = 0.5
	-- newAnimation(plane_img, 200, 200, 0, 2)
end

function Spaceship:backToTheRoots()
	self.v = vector(0,0)
	self.rotation = 0
	self.x = self.startX
	self.y = self.startY
	self:invertPolarisation(1)
end

function Spaceship:update(dt)
	self:calculatePosition(dt)
end

function Spaceship:draw()
	-- love.graphics.draw( drawable, x, y, orientation, scaleX, scaleY, originX, originY )
	self.spaceship_animation:draw(self.x, self.y,
		self.rotation / 180 * math.pi, self.scale, self.scale, 
		self.width / 2, self.height / 2)
end

function Spaceship:calculatePosition(dt)
	self.x = self.x - self.v.x * dt
	self.y = self.y - self.v.y * dt
end

function Spaceship:accelerate(dt)
	-- The acceleration is applied independently of the current moving direction
	local acceleration = vector(0,1):rotated((self.rotation/180) * math.pi)
	self.v = self.v + acceleration * dt * 100 -- TODO: 100?
end

function Spaceship:rotate(degree)
	self.rotation = math.mod(self.rotation - degree, 360)
end

function Spaceship:getSpeed()
	return self.v.len()
end

function Spaceship:getXPos()
	return self.x
end

function Spaceship:getYPos()
	return self.y
end

function Spaceship:getPolarisation()
	return self.polarisation
end

function Spaceship:invertPolarisation(polarisation)
	self.polarisation = math.mod(polarisation + 1, 2) -- (polarisation +1)%2
	self.spaceship_animation:seek(self.polarisation + 1)
end

function Spaceship:scaleSpaceshipPolygon()
	for x in self.spaceship_polygon do
		x = x*self.scale
	end
end

function Spaceship:rotateSpaceshipPolygon()
	rot_in_deg = math.rad(self.rotation)
	for i=1, # self.spaceship_polygon, 2 do
  		self.spaceship_polygon[i] 	= (math.cos(rot_in_deg)*self.spaceship_polygon[i]) 
  			+ (-1*math.sin(rot_in_deg)*self.spaceship_polygon[i+1])
  		self.spaceship_polygon[i+1]	= (math.sin(rot_in_deg)*self.spaceship_polygon[i]) 
  			+ (   math.cos(rot_in_deg)*self.spaceship_polygon[i+1])
 	end
end