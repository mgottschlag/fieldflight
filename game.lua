
Gamestate = require "hump.gamestate"

require "level"

game = Gamestate.new()

function game:init()
end

function game:enter(previous, filename)
	-- Load level
	game.level = Level()
	if not game.level.load(filename) then
		-- TODO: Switch back to the menu and pass an error
	end
	-- Initialize player
	-- TODO

	--Initialize joystick settings

	--Initialize Plane
end

function game:update(dt)
	dt = math.min(dt, tonumber(main.setting:getValue("framerate", "1/30")))
	
end

function game:draw()
	-- TODO
end

function game:keyreleased(key)
	-- TODO
end

function game:mousereleased(x,y, mouse_btn)
	-- TODO
end
