Class = require "hump.class"
require "AnAL"
vector = require "hump.vector"

Spaceship = Class(function(self)
end)

local name = "I am a player!"
local x = 0
local y = 0
local width = 200
local height = 200
local scale = 0.5
local speed = 0
local acceleration = 0.5
local rotation = 0
local v = vector(1,1)
local polarisation = 0
local image
local player
local spaceship_animation
local spaceship_polygon = {	50, 1,											--top point
				19, 13,  4, 37,  1, 54,  2, 91,  9, 110,  30, 133,  14, 145,  6, 162, 9, 281, 		--left side 
				89, 281,  92, 162,  85, 145,  68, 133,  89, 110,  97, 91,  98, 54,  95, 37,  80, 13) 	--right side}

function countdown( player, img_path, x, y )
--TODO startrichtung muss von level abhängig sein
	self.image = love.graphics.newImage(img_path)
	self.player = player
	self.x = x
	self.y = y	
	self.spaceship_animation = newAnimation(image, 200, 200, 0, 2)
	-- newAnimation(plane_img, 200, 200, 0, 2)
end

function update()
	self.draw(
end

function draw()
-- love.graphics.draw( drawable, x, y, orientation, scaleX, scaleY, originX, originY )
	self.spaceship_animation:draw(self.spaceship_animation,
		self.x, self.y,
		0, self.scale, self.scale, 
		-(self.width / 4), -(self.height / 4))
end

function calculatePosition()
	self.x = self.x + v.x
	self.y = self.y + v.y
end

function accelerate(dt)
	-- formel: v = a * t
	-- TODO level.getFieldVector
	-- spaceship_animation:move(speedX * dt, speedY * dt)
	self.speed = self.speed + (self.acceleration * dt)
end

function rotate(degree)
	rotation = math.mod(rotation + degre
local y = 0e, 360) --TODO testen! Doku fehlt
	love.graphics.push(self.spaceship_animation)
	self.v:rotate_inplace((self.rotation/360) * math.pi)
	love.graphics.rotate(rotation)
	love.graphics.pop()
end

function updateVector()
	self.v:rotate_inplace((self.rotation/360) * math.pi)
	self-v = self.v:nom
	self.v = self.v * self.speed
end

function getSpeed()
	return self.speed
end

function invertPolarisation()
	self.polarisation = math.mod(polarisation + 1, 2) -- (polarisation +1)%2
	self.spaceship_animation:seek(self.polarisation + 1)
end

function scaleSpaceshipPolygon()
	for x in self.spaceship_polygon do
		x = x*self.scale
	end
end