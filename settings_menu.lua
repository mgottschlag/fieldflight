
Gamestate = require "hump.gamestate"
goo = require "goo/goo"

local menu_controls = {}

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
		-- TODO: Save settings
		Gamestate.switch(menu)
	end
end

function settings_menu:initGeneral()
	-- Music volume
	menu_controls["music"] = goo.slider:new()
	
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