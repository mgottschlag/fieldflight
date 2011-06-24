
Gamestate = require "hump.gamestate"
goo = require "goo/goo"

require "game"
require "settings_menu"
require "singleplayer_menu"


menu = Gamestate.new()

main_buttons = {}

function menu:init()

	local center_x = love.graphics.getWidth() / 2
	local center_y = love.graphics.getHeight() / 2
	local font_size = 15
	-- Singleplayer button
	main_buttons["singleplayer"] = goo.button:new()
	main_buttons["singleplayer"]:setPos(center_x - 100, center_y - 100)
	main_buttons["singleplayer"]:setText("Singleplayer")
	main_buttons["singleplayer"].onClick = function(self, button)
		Gamestate.switch(singleplayer_menu)
	end
	-- Multiplayer button
	main_buttons["multiplayer"] = goo.button:new()
	main_buttons["multiplayer"]:setPos(center_x - 100, center_y - 50)
	main_buttons["multiplayer"]:setText("Multiplayer")
	-- Settings button
	main_buttons["settings"] = goo.button:new()
	main_buttons["settings"]:setPos(center_x - 100, center_y)
	main_buttons["settings"]:setText("Settings")
	main_buttons["settings"].onClick = function(self, button)
		Gamestate.switch(settings_menu)
	end
	-- Quit button
	main_buttons["quit"] = goo.button:new()
	main_buttons["quit"]:setPos(center_x - 100, center_y + 50)
	main_buttons["quit"]:setText("Quit")
	main_buttons["quit"].onClick = function(self, button)
		-- TODO: Show credits?
		love.event.push("q")
	end
	for k,v in pairs(main_buttons) do
		v:setSize(200, 40)
		v.style.textFont = love.graphics.newFont(font_size)
		v:setVisible(false)
	end
end

function menu:enter(previous)
	for k,v in pairs(main_buttons) do
		v:setVisible(true)
	end
end

function menu:leave()
	for k,v in pairs(main_buttons) do
		v:setVisible(false)
	end
end

function menu:update(dt)
	goo:update(dt)
end

function menu:draw()
	goo:draw()
end

function menu:keypressed(key, unicode)
	goo:keypressed(key, unicode)
end
function menu:keyreleased(key, unicode)
	goo:keyreleased(key, unicode)
end

function menu:mousepressed(x,y, mouse_btn)
	goo:mousepressed(x, y, mouse_btn)
end
function menu:mousereleased(x,y, mouse_btn)
	goo:mousereleased(x, y, mouse_btn)
end