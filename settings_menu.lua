
Gamestate = require "hump.gamestate"
goo = require "goo/goo"

local menu_controls = {}
local progressbar_width = 200
local progressbar_height = 20
local progressbar_distance = 40

settings_menu = Gamestate.new()

function settings_menu:init()
	self:initButtons()
	self:initGeneral()
	self:initControls()
end

function settings_menu:initButtons()
	local screen_width = love.graphics.getWidth()
	local screen_height = love.graphics.getHeight()
	-- Cancel button
	menu_controls["back"] = goo.button:new()
	menu_controls["back"]:setPos(screen_width - 220, screen_height - 50)
	menu_controls["back"]:setSize(200, 40)
	menu_controls["back"]:setText("Back")
	menu_controls["back"].onClick = function(self, button)
		Gamestate.switch(menu)
	end
	-- Accept button
	menu_controls["accept"] = goo.button:new()
	menu_controls["accept"]:setPos(screen_width - 430, screen_height - 50)
	menu_controls["accept"]:setSize(200, 40)
	menu_controls["accept"]:setText("Accept")
	menu_controls["accept"].onClick = function(self, button)
		
		setting:setValue("player1ButtonLeft", links)
		setting:setValue("player1ButtonRight", rechts)
		setting:setValue("player1ButtonVollgas", up)
		if love.joystick.getNumJoysticks() > 0 then
			for i = 0, love.joystick.getNumJoysticks() do
				if menu_controls["player1UsesJoystick"..i]:isChecked() then
					setValue("player1UsesJoystickNumber", i)
				end
			end
		end
		
		setting:setValue("player2ButtonLeft", links2)
		setting:setValue("player2ButtonRight", rehts2)
		setting:setValue("player2ButtonVollgas", up2)
		if love.joystick.getNumJoysticks() > 0 then
			for i = 0, love.joystick.getNumJoysticks() do
				if menu_controls["player2UsesJoystick"..i]:isChecked() then
					setValue("player2UsesJoystickNumber", i)
				end
			end
		end
		
		Gamestate.switch(menu)
	end
	
	--text p1
	menu_controls["p1Text"] = goo.text:new()
	menu_controls["p1Text"]:setPos(500, 30)
	menu_controls["p1Text"]:setText("Spieler1")
	--button select keys acc
	menu_controls["button_selectUp"] = goo.button:new()
	menu_controls["button_selectUp"]:setPos(550, 50)
	menu_controls["button_selectUp"]:setSize(100, 50)
	menu_controls["button_selectUp"]:setText("Acc")
	menu_controls["button_selectUp"].onClick = function(self, button)
		self.up = settings_menu:selectButton()
		if self.up == self.links then
			self.links = nil
			menu_controls["button_selectLeft"]:setText("Left")
		end
		if self.up == self.rechts then
			self.rechts = nil
			menu_controls["button_selectRight"]:setText("Right")
		end
		menu_controls["button_selectUp"]:setText("Acc\n"..self.up)
	end
	
	
	--button select keys left
	menu_controls["button_selectLeft"] = goo.button:new()
	menu_controls["button_selectLeft"]:setPos(500, 100)
	menu_controls["button_selectLeft"]:setSize(100, 50)
	menu_controls["button_selectLeft"]:setText("Left")
	menu_controls["button_selectLeft"].onClick = function(self, button)
		self.links = settings_menu:selectButton()
		if self.links == self.up then
			self.up = nil
			menu_controls["button_selectUp"]:setText("Acc")
		end
		if self.links == self.rechts then
			self.rechts = nil
			menu_controls["button_selectRight"]:setText("Right")
		end
		menu_controls["button_selectLeft"]:setText("Left\n"..self.links)
	end
	
	--button select keys right
	menu_controls["button_selectRight"] = goo.button:new()
	menu_controls["button_selectRight"]:setPos(600, 100)
	menu_controls["button_selectRight"]:setSize(100,50)
	menu_controls["button_selectRight"]:setText("Right")
	menu_controls["button_selectRight"].onClick = function(self, button)
		self.rechts = settings_menu:selectButton()
		if self.rechts == self.links then
			self.links = nil
			menu_controls["button_selectLeft"]:setText("Left")
		end
		if self.up == self.rechts then
			self.up = nil
			menu_controls["button_selectUp"]:setText("Acc") 
		end
		menu_controls["button_selectRight"]:setText("Right\n"..self.rechts)
	end
	
	for i = 1, love.joystick.getNumJoysticks() do
		menu_controls["p1UsesJoystick"..i] = goo.checkbox:new()
		menu_controls["p1UsesJoystick"..i]:setPos(480,160)
		menu_controls["useJoystickText"..i] = goo.text:new()
		menu_controls["useJoystickText"..i]:setText(love.joystick.getName(i - 1))
		menu_controls["useJoystickText"..i]:setPos(500, 160 + 50 * i)
	end
	
	--text p2
	menu_controls["p2Text"] = goo.text:new()
	menu_controls["p2Text"]:setPos(500, 330)
	menu_controls["p2Text"]:setText("Spieler2")
	--button select keys acc
	menu_controls["button_selectUp2"] = goo.button:new()
	menu_controls["button_selectUp2"]:setPos(550, 350)
	menu_controls["button_selectUp2"]:setSize(100, 50)
	menu_controls["button_selectUp2"]:setText("Acc")
	menu_controls["button_selectUp2"].onClick = function(self, button)
		self.up2 = settings_menu:selectButton()
		if self.up2 == self.links2 then
			self.links2 = nil
			menu_controls["button_selectLeft2"]:setText("Left")
		end
		if self.up2 == self.rechts2 then
			self.rechts2 = nil
			menu_controls["button_selectRight2"]:setText("Right")
		end
		menu_controls["button_selectUp2"]:setText("Acc\n"..self.up2)
	end
	
	
	--button select keys left
	menu_controls["button_selectLeft2"] = goo.button:new()
	menu_controls["button_selectLeft2"]:setPos(500, 400)
	menu_controls["button_selectLeft2"]:setSize(100, 50)
	menu_controls["button_selectLeft2"]:setText("Left")
	menu_controls["button_selectLeft2"].onClick = function(self, button)
		self.links2 = settings_menu:selectButton()
		if self.links2 == self.up2 then
			self.up2 = nil
			menu_controls["button_selectUp2"]:setText("Acc")
		end
		if self.links2 == self.rechts2 then
			self.rechts2 = nil
			menu_controls["button_selectRight2"]:setText("Right")
		end
		menu_controls["button_selectLeft2"]:setText("Left\n"..self.links2)
	end
	
	--button select keys right
	menu_controls["button_selectRight2"] = goo.button:new()
	menu_controls["button_selectRight2"]:setPos(600, 400)
	menu_controls["button_selectRight2"]:setSize(100,50)
	menu_controls["button_selectRight2"]:setText("Right")
	menu_controls["button_selectRight2"].onClick = function(self, button)
		self.rechts2 = settings_menu:selectButton()
		if self.rechts2 == self.links2 then
			self.links2 = nil
			menu_controls["button_selectLeft"]:setText("Left")
		end
		if self.up2 == self.rechts2 then
			self.up2 = nil
			menu_controls["button_selectUp2"]:setText("Acc") 
		end
		menu_controls["button_selectRight2"]:setText("Right\n"..self.rechts2)
	end
	
	for i = 1, love.joystick.getNumJoysticks() do
		menu_controls["p2UsesJoystick"..i] = goo.checkbox:new()
		menu_controls["p2UsesJoystick"..i]:setPos(480,460)
		menu_controls["useJoystickText2"..i] = goo.text:new()
		menu_controls["useJoystickText2"..i]:setText(love.joystick.getName(i - 1))
		menu_controls["useJoystickText"..i]:setPos(500, 460 + 50 * i)
	end
	
	
	-- Volume progressbar
	---menu_controls["volume_progress"] = goo.progressbar:new()
	--menu_controls["volume_progress"]:setSize(progressbar_width, progressbar_height)
	--menu_controls["volume_progress"]:setPos( (screen_width/2)-(progressbar_width/2) , screen_height/2)
	--menu_controls["volume_progress"]:setRange(0, 100)
	--menu_controls["volume_progress"]:setProgress(50)
end

function settings_menu:selectButton()
	local value = nil
	if love.keyboard.isDown("a") then
		self.value = "a"
	elseif love.keyboard.isDown("b") then
		self.value = "b"
	elseif love.keyboard.isDown("c") then
		self.value = "c"
	elseif love.keyboard.isDown("d") then
		self.value = "d"
	elseif love.keyboard.isDown("e") then
		self.value = "e"
	elseif love.keyboard.isDown("f") then
		self.value = "f"
	elseif love.keyboard.isDown("g") then
		self.value = "g"
	elseif love.keyboard.isDown("h") then
		self.value = "h"
	elseif love.keyboard.isDown("i") then
		self.value = "i"
	elseif love.keyboard.isDown("j") then
		self.value = "j"
	elseif love.keyboard.isDown("k") then
		self.value = "k"
	elseif love.keyboard.isDown("l") then
		self.value = "l"
	elseif love.keyboard.isDown("m") then
		self.value = "m"
	elseif love.keyboard.isDown("n") then
		self.value = "n"
	elseif love.keyboard.isDown("o") then
		self.value = "o"
	elseif love.keyboard.isDown("p") then
		self.value = "p"
	elseif love.keyboard.isDown("q") then
		self.value = "q"
	elseif love.keyboard.isDown("r") then
		self.value = "r"
	elseif love.keyboard.isDown("s") then
		self.value = "s"
	elseif love.keyboard.isDown("t") then
		self.value = "t"
	elseif love.keyboard.isDown("u") then
		self.value = "u"
	elseif love.keyboard.isDown("v") then
		self.value = "v"
	elseif love.keyboard.isDown("w") then
		self.value = "w"
	elseif love.keyboard.isDown("x") then
		self.value = "x"
	elseif love.keyboard.isDown("y") then
		self.value = "y"
	elseif love.keyboard.isDown("z") then
		self.value = "z"
	elseif love.keyboard.isDown("left") then
		self.value = "left"
	elseif love.keyboard.isDown("right") then
		self.value = "right"
	elseif love.keyboard.isDown("up") then
		self.value = "up"
	elseif love.keyboard.isDown("down") then
		self.value = "down"
	else return nil
	end
	return self.value
end

function settings_menu:initGeneral()
	-- Music volume
	--menu_controls["music"] = goo.slider:new()
	
	-- TODO
	-- Effect volume
	-- TODO
end

function settings_menu:initControls()
	-- Player 1: Name, controls, ship, color (RGB)
end

function settings_menu:enter(previous)
	for k,v in pairs(menu_controls) do
		v:setVisible(true)
	end
end

function settings_menu:leave()
	for k,v in pairs(menu_controls) do
		v:setVisible(false)
	end
end

function settings_menu:update(dt)
	goo:update(dt)
end

function settings_menu:draw()
	goo:draw(dt)
end

function settings_menu:keypressed(key, unicode)
	goo:keypressed(key, unicode)
end
function settings_menu:keyreleased(key, unicode)
	goo:keyreleased(key, unicode)
end

function settings_menu:mousepressed(x,y, mouse_btn)
	goo:mousepressed(x, y, mouse_btn)
end
function settings_menu:mousereleased(x,y, mouse_btn)
	goo:mousereleased(x, y, mouse_btn)
end