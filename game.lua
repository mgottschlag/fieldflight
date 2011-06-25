require "anal/AnAL"
require "tesound/TEsound"

Gamestate = require "hump.gamestate"

require "level"
require "player"

game = Gamestate.new()
local numberOfPlayers = 1




function game:init()
	self.player1 = Player()
end

function game:enter(previous, filename)
	-- Load level
	game.level = Level()
	if not game.level:load(filename) then
		-- TODO: Switch back to the menu and pass an error
	end
	-- Initialize players
	self.player1:init(1,dt)
	
	--initilize sound
	--source = love.audio.newSource( "sound/main.wav" , "stream" )
	--TODO tesound
	
end

function game:update(dt)
	dt = math.min(dt, tonumber(setting:getValue("framerate", tostring(1/30))))
	
	
end

function game:draw()
	--Let the players check the input sources
	for i = 1, numberOfPlayers do
		self["player"..i]:checkInput()
		self["player"..i].spaceship:draw()
	end
	
	test_level:draw(Vector.new(50, 50), Vector.new(0, 0),
		Vector.new(300, 300))
	test_level:drawFieldVectors(Vector.new(50, 50), Vector.new(0, 0),
		Vector.new(300, 300), Vector.new(100, 100), 70)
end

function game:keyreleased(key)
	-- TODO
end

function game:mousereleased(x,y, mouse_btn)
	-- TODO
end