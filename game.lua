
Gamestate = require "hump.gamestate"

game = Gamestate.new()

function game:init()
end

function game:enter(previous)
	-- Load level
	game.level = Level:new()
	if not game.load("test") then
		-- TODO: Create an error
	end
	-- TODO
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

