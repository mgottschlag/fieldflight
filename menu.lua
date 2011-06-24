
Gamestate = require "hump.gamestate"
goo = require "goo/goo"

require "game"

menu = Gamestate.new()


function menu:init()
	-- TODO: Initialize gui
	local center_x = love.graphics.getWidth() / 2
	local center_y = love.graphics.getHeight() / 2
	-- Singleplayer button
	local sp_button = goo.button:new()
	sp_button:setPos(center_x - 100, center_y - 100)
	sp_button:setSize(200, 40)
	sp_button:setText("Singleplayer")
	sp_button.style.textFont = love.graphics.newFont(40)
	-- Multiplayer button
	local mp_button = goo.button:new()
	mp_button:setPos(center_x - 100, center_y - 50)
	mp_button:setSize(200, 40)
	mp_button:setText("Multiplayer")
	sp_button.style.textFont = love.graphics.newFont(40)
	-- Settings button
	local settings_button = goo.button:new()
	settings_button:setPos(center_x - 100, center_y)
	settings_button:setSize(200, 40)
	settings_button:setText("Settings")
	sp_button.style.textFont = love.graphics.newFont(40)
	-- Quit button
	local quit_button = goo.button:new()
	quit_button:setPos(center_x - 100, center_y + 50)
	quit_button:setSize(200, 40)
	quit_button:setText("Quit")
	sp_button.style.textFont = love.graphics.newFont(40)
end

function menu:enter(previous)
	-- TODO
end

function menu:leave()
end

function menu:update(dt)
	goo:update(dt)
end

function menu:draw()
	goo:draw(dt)
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

