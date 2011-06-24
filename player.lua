Class = require "hump.class"
require "main"
require "settings"

Player = Class(functon(self)
end)

local name = "dummyName"
spaceship = Spaceship:new()
local spaceshipImagePath = ""
local colorRed = 0
local colorGreen = 0
local colorBlue = 0
local usesJoystickNumber = -1	-- -1=kein Joystick
local usesJoystickAxis = -1 	-- -1=Achsen werden nicht benutzt
local buttonLeft = "left"
local buttonRight = "right"
local buttonVollgas = "up"

function init(number, dt)
	name = main.setting:getValue("player"..number, "DummyName")
	colorRed = main.setting:getValue("player"..number.."ColorRed", "0")
	colorGreen = main.setting:getValue("player"..number.."ColorGreen", "0")
	colorBlue = main.setting:getValue("player"..number.."ColorBlue", "0")
	usesJoystickNumber = main.setting:getValue("player"..number.."UsesJoystickNumber", "-1")
	usesJoystickAxis = main.setting:getValue("player"..number.."UsesJoystickAxis", "-1")
	spaceshipImagePath = main.setting:getValue("player"..number.."spaceshipImagePath", "DummyImagePath")
	spaceship:countdown(self, spaceShipImagePath, 100, 100)
	buttonLeft = main.setting:getValue("player"..number.."buttonLeft", "left")
	buttonRight = main.setting:getValue("player"..number.."buttonRight", "right")
	buttonUp = main.setting:getValue("player"..number.."buttonVollgas", "up")
end

function checkInput()
	if love.joystick.getNumJoysticks > 0 and usesJoystickNumber > -1 then
		--Achsen werden benutzt
		if usesJoystickAxis == 1 then
			axisDir1, axisDir2, axisDirN = love.joystick.getAxes( joystickNumber )
			if axisDir1 > 0 then
				spaceship:rotate(360/dt)
			elseif axisDir1 < 0
				spaceship:rotate(-360/dt)
			end
			if axisDir2 < 0
				spaceship:accelerate(dt)
			return
		end
		--Achsen werden nicht benutzt
		if love.joystick.isDown(joystickNumber, buttonLeft)
			spaceship:rotate(360/dt)
		else if love.joystick.isDown(joystickNumber, buttonRight)
			spaceship:rotate(-360/dt)
		elseif love.joystick.isDown(joystickNumber, buttonVollgas)
			spaceship:accelerate(dt)
		end
		--Joystick auslesen fertig
		return
	end
	--Joystick wird nicht benutzt
	if love.keyboard.isDown(buttonLeft)
		spaceship:rotate(360/dt)
	else if love.keyboard.isDown(buttonright)
		spaceship:rotate(-360/dt)
	elseif love.keyboard.isDown(buttonVollgas)
		spaceship:accelerate(dt)
	end	
end