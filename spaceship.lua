Class = require "hump.class"
require "AnAL"

Spaceship = Class(function(self)
end)

local name = "I am a player!"
local x = 0
local speed = 0
local acceleration = 0.5
local y = 0
local rotation = 0
local image
local player
local spaceship_animation

function countdown( player, img_path, x, y )
	self.image = love.graphics.newImage(img_path)
	self.player = player
	self.x = x
	self.y = y
	self.spaceship_animation = newAnimation(image, 200, 200, 0, 2)
	-- newAnimation(plane_img, 200, 200, 0, 2)
end

function accelerate(dt)
	-- formel: v = a * t
	-- TODO level.getFieldVector
	-- spaceship_animation:move(speedX * dt, speedY * dt)
	self.speed = self.speed + (self.acceleration * dt)
end

function rotate(degree)
	rotation = math.mod(rotation + degree, 360) --TODO testen! Doku fehlt
	love.graphics.push(self.spaceship_animation)
	love.graphics.rotate
end

function getSpeed()
	return self.speed
end

function invertPolarisation()
	
end