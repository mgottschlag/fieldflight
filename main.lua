
require "settings"
require "menu"

require "goo/goo"


function love.load()
	goo:load()
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


