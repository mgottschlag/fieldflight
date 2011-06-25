Class = require "hump.class"

require "settings"
require "spaceship"

Player = Class(function(self)
	self.name = "I am a player!"
	self.spaceship = Spaceship()
	self.spaceshipImagePath = ""
	self.colorRed = 0
	self.colorGreen = 0
	self.colorBlue = 0
	self.usesJoystickNumber = -1	-- -1=kein Joystick
	self.usesJoystickAxis = -1 	-- -1=Achsen werden nicht benutzt
	self.buttonLeft = "left"
	self.buttonRight = "right"
	self.buttonVollgas = "up"
end)

function Player:init(number, dt, level)
	self.name = setting:getValue("player"..number, "DummyName")
	self.colorRed = setting:getValue("player"..number.."ColorRed", "0")
	self.colorGreen = setting:getValue("player"..number.."ColorGreen", "0")
	self.colorBlue = setting:getValue("player"..number.."ColorBlue", "0")
	self.usesJoystickNumber = setting:getValue("player"..number.."UsesJoystickNumber", "-1")
	self.usesJoystickAxis = setting:getValue("player"..number.."UsesJoystickAxis", "-1")
	self.spaceshipImagePath = setting:getValue("player"..number.."spaceshipImagePath", "graphics/Spaceship.png")
	self.spaceship:countdown(self, self.spaceshipImagePath, 100, 100)
	self.buttonLeft = setting:getValue("player"..number.."buttonLeft", "left")
	self.buttonRight = setting:getValue("player"..number.."buttonRight", "right")
	self.buttonUp = setting:getValue("player"..number.."buttonVollgas", "up")
	-- Initialize arrow
	self.arrow = Arrow()
	self.arrow:init(self.spaceship, level)
end

function Player:checkInput(dt)
	if love.joystick.getNumJoysticks() > 0 and usesJoystickNumber > -1 then
		--Achsen werden benutzt
		if usesJoystickAxis == 1 then
			axisDir1, axisDir2, axisDirN = love.joystick.getAxes( joystickNumber )
			if axisDir1 > 0 then
				self.spaceship:rotate(360*dt)
			elseif axisDir1 < 0 then
				self.spaceship:rotate(-360*dt)
			end
			if axisDir2 < 0 then
				self.spaceship:accelerate(dt)
			end
			return
		end
		--Achsen werden nicht benutzt
		if love.joystick.isDown(joystickNumber, self.buttonLeft) then
			self.spaceship:rotate(360*dt)
		elseif love.joystick.isDown(joystickNumber, self.buttonRight) then
			self.spaceship:rotate(-(360*dt))
		elseif love.joystick.isDown(joystickNumber, self.buttonVollgas) then
			self.spaceship:accelerate(dt)
		end
		--Joystick auslesen fertig
		return
	end
	--Joystick wird nicht benutzt
	if love.keyboard.isDown(self.buttonLeft) then
		self.spaceship:rotate(360*dt)
	elseif love.keyboard.isDown(self.buttonRight) then
		self.spaceship:rotate(-(360*dt))
	elseif love.keyboard.isDown(self.buttonVollgas) then
		self.spaceship:accelerate(dt)
	end	
end
