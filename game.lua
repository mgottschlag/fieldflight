
Gamestate = require "hump.gamestate"

require "level"

game = Gamestate.new()

function game:init()
end

function game:enter(previous, filename)
	-- Load level
	game.level = Level:new()
	if not game.load(filename) then
		-- TODO: Switch back to the menu and pass an error
	end
	-- Initialize player
	-- TODO
end

function game:update(dt)
	-- TODO
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

