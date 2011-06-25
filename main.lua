
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

	-- test level
	-- TODO: Remove before flight
	--test_level = Level()
	--test_level:load("test.level")
	

	-- At startup, just show the menu
	-- TODO: Show some intro screen here
	Gamestate.switch(menu)
end

function love.update()
	love.graphics.setBackgroundColor(0, 0, 0, 255)
	love.graphics.clear()
end

function love.draw()
	--test_level:draw(Vector.new(50, 50), Vector.new(0, 0),
	--	Vector.new(300, 300))
	--test_level:drawFieldVectors(Vector.new(50, 50), Vector.new(0, 0),
	--	Vector.new(300, 300), Vector.new(100, 100), 70)
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


