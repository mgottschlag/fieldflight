require "anal/AnAL"
require "tesound/TEsound"

Gamestate = require "hump.gamestate"

require "level"
require "player"

game = Gamestate.new()
local numberOfPlayers = 1
local player1 = Player()




function game:init()
end

function game:enter(previous, filename)
	-- Load level
	game.level = Level()
	if not game.level:load(filename) then
		-- TODO: Switch back to the menu and pass an error
	end
	-- Initialize players
	player1:init(1,dt)
	
	--initilize sound
	--source = love.audio.newSource( "sound/main.wav" , "stream" )
	--TODO tesound
	
end

function game:update(dt)
	dt = math.min(dt, tonumber(setting:getValue("framerate", "1/30")))
	
	--Let the players check the input sources
	for i = 1, numberOfPlayers do
		self["player"..i]:checkInput()
		self["player"..i].spaceship:update()
	end
	
end

function game:draw()
	-- love.graphics.draw( drawable, x, y, orientation, scaleX, scaleY, originX, originY )
end

function game:keyreleased(key)
	-- TODO
end

function game:mousereleased(x,y, mouse_btn)
	-- TODO
end