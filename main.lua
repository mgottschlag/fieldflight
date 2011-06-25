
require "settings"
require "menu"

require "goo/goo"
HC = require "hardoncollider"

function love.load()
	goo:load()
	HC.init(100, on_collision, collision_stop)
	Gamestate.registerEvents()

	-- Initialize Joysticks
	numberOfJoysticks = love.joystick.getNumJoysticks()
	joystickNames = {}
	for i = 0, numberOfJoysticks do
	  joystickNames[i] = love.joystick.getName(i)
	end

	-- load settings
	setting = Settings()
	setting:loadSettings("game_settings")

	-- At startup, just show the menu
	-- TODO: Show some intro screen here
	Gamestate.switch(menu)
end

function love.update()
	love.graphics.setBackgroundColor(0, 0, 0, 255)
	love.graphics.clear()
end

function love.draw()
end

function love.mousepressed(x, y, button)
end
function love.mousereleased(x, y, button)
end

function love.keypressed(key, unicode)
end
function love.keyreleased(key, unicode)
end

function love.focus(f)
end

function love.quit()
end
