Class = require "hump.class"
require "anal/AnAL"
vector = require "hump.vector"

Spaceship = Class(function(self)
	local v = vector(1,1)
	local rotation = 0
	local polarisation = 0
	local speed = 0
	local x = 0
	local y = 0
	local startX = 0
	local startY = 0
	local initialized --TODO weg!

	--self.image
	--self.player
	--self.spaceship_animation
end)

-- constant
local width = 200
local height = 200
local scale = 0.5
local acceleration = 0.5
local spaceship_polygon = {	50, 1,											--top point
				19, 13,  4, 37,  1, 54,  2, 91,  9, 110,  30, 133,  14, 145,  6, 162, 9, 281, 		--left side 
				89, 281,  92, 162,  85, 145,  68, 133,  89, 110,  97, 91,  98, 54,  95, 37,  80, 13} 	--right side}

function Spaceship:countdown( player, img_path, x, y )
--TODO startrichtung muss von level abhängig sein
	self.startX = x
	self.startY = y
	self.image = love.graphics.newImage(img_path)
	self.spaceship_animation = newAnimation(self.image, 200, 200, 0, 1)
	self:backToTheRoots()
	self.player = player
	self.width = 200
	self.height = 200
	self.scale = 0.5
	self.acceleration = 0.5
	-- newAnimation(plane_img, 200, 200, 0, 2)
end

function Spaceship:backToTheRoots()
	self.v = vector(1,1)
	self.rotation = 0
	self.speed = 0
	self.x = self.startX
	self.y = self.startY
	self:invertPolarisation(1)
end

function Spaceship:update()
	self:draw()
	self.initialized = 1
end

function Spaceship:draw()
	self:updateVector()
	self:calculatePosition()
	-- love.graphics.draw( drawable, x, y, orientation, scaleX, scaleY, originX, originY )
	self.spaceship_animation:draw(self.x, self.y,
	0, 1, 1,
		--0, self.scale, self.scale, 
		-50, -50)
	--	-(self.width / 4), -(self.height / 4))
end

function Spaceship:calculatePosition()
	--TODO was geht hier nicht?
	local add = 0
	--if self.v ~≃ nil then 
	--	add = self.v.x 
	--end
	self.x = self.x + add
	--if (self.v =≃ nil) then else add = self.v.x end
	self.y = self.y + add
end

function Spaceship:accelerate(dt)
	-- formel: v = a * t
	-- TODO level.getFieldVector
	-- spaceship_animation:move(speedX * dt, speedY * dt)
	self.speed = self.speed + (self.acceleration * dt)
end

function Spaceship:rotate(degree)
	rotation = math.mod(rotation + degre/360) --TODO testen! Doku fehlt
	love.graphics.push(self.spaceship_animation)
	love.graphics.rotate(rotation)
	love.graphics.pop()
end

function Spaceship:updateVector()
	self.v:rotate_inplace((self.rotation/360) * math.pi)
	self.v:normalize_inplace()
	self.v = self.v * self.speed
end

function Spaceship:getSpeed()
	return self.speed
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
  		self.spaceship_polygon[i] 	= (math.cos(rot_in_deg)*self.spaceship_polygon[i]) + (-1*math.sin(rot_in_deg)*self.spaceship_polygon[i+1])
  		self.spaceship_polygon[i+1]	= (math.sin(rot_in_deg)*self.spaceship_polygon[i]) + (   math.cos(rot_in_deg)*self.spaceship_polygon[i+1])
 	end
end