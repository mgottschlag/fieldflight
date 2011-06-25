Gamestate = require "hump.gamestate"
goo = require "goo/goo"


singleplayer_menu = Gamestate.new()

singleplayer_menu_gui_elements = {}

function singleplayer_menu:init()
	local center_x = love.graphics.getWidth() / 2
	local center_y = love.graphics.getHeight() / 2
	local font_size = 15
	--Überschrift für Colorpick
	--singleplayer_menu_gui_elements["colorPickHeaderfunction singleplayer_menu:enter()
	--singleplayer_menu_gui_elements["colorPickHeader"]:setText("Spielerfarbe")
	--singleplayer_menu_gui_elements["colorPickHeader"]:setPos(50,0)
	
	--Colorpick
	--singleplayer_menu_gui_elements["colorPick"] = goo.colorpick:new()
	--singleplayer_menu_gui_elements["colorPick"]:setPos(50,50)
	
	--button back
	singleplayer_menu_gui_elements["button_back"] = goo.button:new()
	singleplayer_menu_gui_elements["button_back"]:setPos(100, 550)
	singleplayer_menu_gui_elements["button_back"]:setSize(200, 50)
	singleplayer_menu_gui_elements["button_back"]:setText("zurueck")
	singleplayer_menu_gui_elements["button_back"].onClick = function(self, button)
		Gamestate.switch(menu)
	end
	
	--button start
	singleplayer_menu_gui_elements["button_start"] = goo.button:new()
	singleplayer_menu_gui_elements["button_start"]:setPos(550, 550)
	singleplayer_menu_gui_elements["button_start"]:setSize(200, 50)
	singleplayer_menu_gui_elements["button_start"]:setText("Start!")
	singleplayer_menu_gui_elements["button_start"].onClick = function(self, button)
		Gamestate.switch(game, "test.level")
	end
end

function singleplayer_menu:enter(previous)
	for k,v in pairs(singleplayer_menu_gui_elements) do
		v:setVisible(true)
	end
end

function singleplayer_menu:leave()
	for k,v in pairs(singleplayer_menu_gui_elements) do
		v:setVisible(false)
	end
end

function singleplayer_menu:update(dt)
	goo:update(dt)
end

function singleplayer_menu:draw()
	goo:draw()
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
end