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
local buttonLeft
local buttonRight
local buttonVollgas

function init(number, dt)
	name = main.setting:getValue("player"..number, "DummyName")
	colorRed = main.setting:getValue("player"..ColorRed, "0")
	colorGreen = main.setting:getValue("player"..ColorGreen, "0")
	colorBlue = main.setting:getValue("player"..ColorBlue, "0")
	usesJoystickNumber = main.setting:getValue("player"..UsesJoystickNumber, "-1")
	usesJoystickAxis = main.setting:getValue("player"..UsesJoystickAxis, "-1")
	spaceshipImagePath = main.setting:getValue("player"..spaceshipImagePath, "DummyImagePath")
	spaceship:countdown(self, spaceShipImagePath, 100, 100)
end

function checkInput()
	if love.joystick.getNumJoysticks > 0 and usesJoystickNumber > -1 then
		--Achsen werden benutzt
		if usesJoystickAxis == 1 then
			axisDir1, axisDir2, axisDirN = love.joystick.getAxes( joystickNumber )
			--Flo informieren
			return
		end
		--Achsen werden nicht benutzt
		if love.joystick.isDown(buttonLeft)
			spaceship:rotate(360/dt)
		else if love.joystick.isDown(buttonright)
			spaceship:rotate(-360/dt)
		elseif love.joystick.isDown(buttonVollgas)
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