require "anal/AnAL"
require "tesound/TEsound"

Gamestate = require "hump.gamestate"

require "level"

game = Gamestate.new()
local numberOfPlayers = 1




function game:init()
end

function game:enter(previous, filename)
	-- Load level
	game.level = Level()
	if not game.level.load(filename) then
		-- TODO: Switch back to the menu and pass an error
	end
	-- Initialize players
	
	--initilize sound
	source = love.audio.newSource( "sound/main.wav" , "stream" )
	--TODO tesound
	
	-- TODO

	--Initialize Plane
	local plane_img = love.graphics.newImage("plane.png")
	plane = newAnimation(plane_img, 200, 200, 0, 2)
end

function game:update(dt)
	dt = math.min(dt, tonumber(main.setting:getValue("framerate", "1/30")))
	
	--Let the players check the input sources
	for i = 1, numberOfPlayers do
		self["player"..i]:checkInput()
		self["player"..i].spaceship:update()
	end
	
end

function game:draw()
	-- love.graphics.draw( drawable, x, y, orientation, scaleX, scaleY, originX, originY )
	plane:draw(math.floor(love.graphics.getWidth / 2), 
		math.floor(love.graphics.getHeight / 2),
		0, 0.5, 0.5, -50, -50)
	
	
end

function game:keyreleased(key)
	-- TODO
end

function game:mousereleased(x,y, mouse_btn)
	-- TODO
end