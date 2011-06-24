Gamestate = require "hump.gamestate"
goo = require "goo/goo"


--[[singleplayer_menu = Gamestate.new()

singleplayer_menu_gui_elements = {}

function singleplayer_menu:init()
	local center_x = love.graphics.getWidth() / 2
	local center_y = love.graphics.getHeight() / 2
	local font_size = 15
	--Überschrift für Colorpick
	--singleplayer_menu_gui_elements["colorPickHeaderfunction singleplayer_menu:enter()
	for k,v in pairs(singleplayer_menu_gui_elements) do
		v:setVisible(true)
	end
end"] = goo.text:new("test")
	--singleplayer_menu_gui_elements["colorPickHeader"]:setText("Spielerfarbe")
	--singleplayer_menu_gui_elements["colorPickHeader"]:setPos(50,0)
	
	--Colorpick
	singleplayer_menu_gui_elements["colorPick"] = goo.colorpick:new()
	singleplayer_menu_gui_elements["colorPick"]:setPos(50,50)
	
	--button back
	singleplayer_menu_gui_elements["button_back"] = goo.button:new()
	singleplayer_menu_gui_elements["button_back"]:setPos(200, 550)
	singleplayer_menu_gui_elements["button_back"]:setText("zurueck")
	singleplayer_menu_gui_elements["button_back"].onClick = function(self, button)
		Gamestate.switch(menu)
	end
	
	--button start
	singleplayer_menu_gui_elements["button_start"] = goo.button:new()
	singleplayer_menu_gui_elements["button_start"]:setPos(650, 550)
	singleplayer_menu_gui_elements["button_start"]:setText("Start!")
	singleplayer_menu_gui_elements["button_start"].onClick = function(self, button)
		Gamestate.switch(game)
	endfunction singleplayer_menu:enter()function sinfunction singleplayer_menu:enter()
	for k,v in pairs(singleplayer_menu_gui_elements) do
		v:setVisible(true)
	end
endfunction singleplayer_menu:enter()
	for k,v in pairs(singleplayer_menu_gui_elements) do
		v:setVisible(true)
	end
endgleplayer_menu:enter()
	for k,v in pairs(singleplayer_menu_gui_elements) do
		v:setVisible(true)
	end
end
	for k,v in pairs(singleplayer_menu_gui_elements) do
		v:setVisible(true)
	end
end
end

--function singleplayer_menu:enter()
--	for k,v in pairs(singleplayer_menu_gui_elements) do
--		v:setVisible(true)
--	end
--end

function singleplayer_menu:update(dt)
	goo:update(dt)
end

function singleplayer_menu:draw()
	goo:draw(dt)
end

function singleplayer_menu:keypressed(key, unicode)
	goo:keypressed(key, unicode)
end
function singleplayer_menu:keyreleased(key, unicode)
	goo:keyreleased(key, unicode)
end

function singleplayer_menu:mousepressed(x,y, mouse_btn)
	goo:mousepressed(x, y, mouse_btn)
end
function singleplayer_menu:mousereleased(x,y, mouse_btn)
	goo:mousereleased(x, y, mouse_btn)
end--]]