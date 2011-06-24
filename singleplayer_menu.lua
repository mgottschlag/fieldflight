Gamestate = require "hump.gamestate"
goo = require "goo/goo"


singleplayer_menu = Gamestate.new()

singleplayer_menu_gui_elements = {}

function singleplayer_menu:init()
	local center_x = love.graphics.getWidth() / 2
	local center_y = love.graphics.getHeight() / 2
	local font_size = 15
	--Überschrift für Colorpick
	singleplayer_menu_gui_elements["colorPickHeader"] = goo.text:new()
	--singleplayer_menu_gui_elements["colorPickHeader"]:setText("Spielerfarbe")
	--singleplayer_menu_gui_elements["colorPickHeader"]:setPos(50,0)
	--Colorpick
	singleplayer_menu_gui_elements["colorPick"] = goo.colorpick:new()
	singleplayer_menu_gui_elements["colorPick"]:setPos(50,50)
end


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
end