Class = require "hump.class"
require "anal/AnAL"
vector = require "hump.vector"
Hardon = require "hardoncollider"

Spaceship = Class(function(self)
	self.v = vector(0,0)
	self.rotation = 0
	self.polarisation = 0
	self.x = 0
	self.y = 0
	self.startX = 0
	self.startY = 0
	self.spaceship_polygon = {	50, 1,			--top point
		19, 13,  4, 37,  1, 54,  2, 91,  9, 110,  30, 
		133,  14, 145,  6, 162, 9, 281, 		--left side 
			89, 281,  92, 162,  85, 145,  68, 133,  89, 
			110,  97, 91,  98, 54,  95, 37,  80, 13} 	--right side}
	
	
	
	self.hardonPolygon = Hardon.addPolygon(unpack(self.spaceship_polygon))
	--self.initialized --TODO weg!

	--self.image
	--self.player
	--self.spaceship_animation
end)

-- constant
local width = 200
local height = 200
local scale = 0.5

function Spaceship:countdown( player, img_path, x, y, rotation )
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
	self:scaleSpaceshipPolygon()
	-- newAnimation(plane_img, 200, 200, 0, 2)
end

function Spaceship:backToTheRoots()
	self.v = vector(0,0)
	self.rotation = 0
	self.x = self.startX
	self.y = self.startY
	self:invertPolarisation(1)
	self.hardonPolygon:setRotation(self.rotation / 180 * math.pi)
	self.hardonPolygon:moveTo(self.x, self.y)
end

function Spaceship:update(dt, level)
	self:calculatePosition(dt, level)
end

function Spaceship:draw(level_offset)
	local xPos = self.x - level_offset.x
	local yPos = self.y - level_offset.y
	-- love.graphics.draw( drawable, x, y, orientation, scaleX, scaleY, originX, originY )
	self.spaceship_animation:draw(xPos, yPos,
		self.rotation / 180 * math.pi, self.scale, self.scale, 
		self.width / 2, self.height / 2)
	
	self.hardonPolygon:draw("fill")

	-- Debug: Forces
	local right = Vector(10, 0):rotated(self.rotation / 180 * math.pi)
	local left = -right
	local right_sample_pos = Vector(self.x, self.y) + right
	local right_field_strength = self.level:getFieldVector(right_sample_pos.x, right_sample_pos.y)
	local left_sample_pos = Vector(self.x, self.y) + left
	local left_field_strength = self.level:getFieldVector(left_sample_pos.x, left_sample_pos.y)
	local center_pos = Vector(self.x, self.y)
	local force = left_field_strength - right_field_strength
	
	drawLineArrow(right_sample_pos - level_offset, right_sample_pos - right_field_strength * 100 - level_offset)
	drawLineArrow(left_sample_pos - level_offset, left_sample_pos + left_field_strength * 100 - level_offset)
	drawLineArrow(center_pos - level_offset, center_pos + force * 1000 - level_offset)
end

function Spaceship:calculatePosition(dt, level)
	-- Apply acceleration because of magnet field
	local right = Vector(0, 15):rotated(self.rotation / 180 * math.pi)
	local left = -right
	local right_sample_pos = Vector(self.x, self.y) + right
	local right_field_strength = level:getFieldVector(right_sample_pos.x, right_sample_pos.y)
	local left_sample_pos = Vector(self.x, self.y) + left
	local left_field_strength = level:getFieldVector(left_sample_pos.x, left_sample_pos.y)
	
	-- TODO: Remove this
	self.level = level

	-- TODO: Calculate rotation
	local acceleration = left_field_strength - right_field_strength
	self.v = self.v + acceleration * dt * 1000 -- TODO: 100?
	print(self.v.x, self.v.y)
	-- Update position
	self.x = self.x + self.v.x * dt
	self.y = self.y + self.v.y * dt
	self.hardonPolygon:setRotation(self.rotation / 180 * math.pi)
	self.hardonPolygon:moveTo(self.x, self.y)
end

function Spaceship:accelerate(dt)
	-- The acceleration is applied independently of the current moving direction
	local acceleration = vector(0,1):rotated((self.rotation/180) * math.pi)
	self.v = self.v - acceleration * dt * 100 -- TODO: 100?
end

function Spaceship:rotate(degree)
	self.rotation = math.mod(self.rotation - degree, 360)
end

function Spaceship:getSpeed()
	return self.v:len()
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
	Hardon.remove(self.hardonPolygon)
	for i=1,#self.spaceship_polygon do
		self.spaceship_polygon[i] = self.spaceship_polygon[i]*self.scale
	end
	self.hardonPolygon = Hardon.addPolygon(unpack(self.spaceship_polygon))
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

function Spaceship:restrictArea(min, max)
	if self.x < min.x then
		self.x = min.x
		self.v.x = math.max(self.v.x, 0)
	end
	if self.y < min.y then
		self.y = min.y
		self.v.y = math.max(self.v.y, 0)
	end
	if self.x > max.x then
		self.x = max.x
		self.v.x = math.min(self.v.x, 0)
	end
	if self.y > max.y then
		self.y = max.y
		self.v.y = math.min(self.v.y, 0)
	end
	self.hardonPolygon:moveTo(self.x, self.y)
end

function Spaceship:destroy()
	Hardon.remove(self.hardonPolygon)
end
