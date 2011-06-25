require "anal/AnAL"
require "tesound/TEsound"

Gamestate = require "hump.gamestate"

require "level"
require "player"
require "arrow"

game = Gamestate.new()
local numberOfPlayers = 1




function game:init()
	self.player1 = Player()
	self.arrow = Arrow()
end

function game:enter(previous, filename)
	-- Load level
	self.level = Level()
	if not self.level:load(filename) then
		-- TODO: Switch back to the menu and pass an error
	end
	-- Initialize players
	self.player1:init(1,dt)
	
	-- Initialize arrow
	self.arrow:init(self.player1.spaceship, self.level)
	
	--initilize sound
	--source = love.audio.newSource( "sound/main.wav" , "stream" )
	--TODO tesound
	
end

function game:update(dt)
	dt = math.min(dt, tonumber(setting:getValue("framerate", tostring(1/30))))
	-- Update the arrow
	self.arrow:update(dt)
	--Let the players check the input devices
	for i = 1, numberOfPlayers do
		self["player"..i]:checkInput(dt)
	end
	for i = 1, numberOfPlayers do
		self["player"..i].spaceship:update(dt)
	end
end

function game:draw()
	self.arrow:draw()
	for i = 1, numberOfPlayers do
		local player_position = Vector(self["player"..i].spaceship.x, self["player"..i].spaceship.y)
		print(player_position.x, player_position.y)
		-- Calculate screen area
		-- TODO
		local scissor_top_left = Vector(0, 0)
		local scissor_size = Vector(love.graphics.getWidth(), love.graphics.getHeight())
		-- Draw level
		local level_offset = Vector(0, 0)
		-- TODO: Offset 
		self.level:drawFieldVectors(level_offset, scissor_top_left,
			scissor_size, player_position, 100)
		self.level:draw(level_offset, scissor_top_left,
			scissor_size)
		--Let the players draw the spaceships
		for j = 1, numberOfPlayers do
			self["player"..j].spaceship:draw()
		end
		-- Draw statistics (speed, time)
		-- TODO
	end
	
end

function game:keyreleased(key)
	-- TODO
end

function game:mousereleased(x,y, mouse_btn)
	-- TODO
end