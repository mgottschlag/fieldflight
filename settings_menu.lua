
Gamestate = require "hump.gamestate"
goo = require "goo/goo"

local menu_controls = {}

settings_menu = Gamestate.new()

function settings_menu:init()
	local screen_width = love.graphics.getWidth()
	local screen_height = love.graphics.getHeight()
	-- Cancel button
	menu_controls["singleplayer"] = goo.button:new()
	menu_controls["singleplayer"]:setPos(screen_width - 220, screen_width - 50)
	menu_controls["singleplayer"]:setSize(200, 40)
	menu_controls["singleplayer"]:setText("Singleplayer")
	menu_controls["singleplayer"].onClick = function(self, button)
		Gamestate.switch(menu)
	end
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