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
	self.player2 = Player()
end

function game:enter(previous, filename, multiplayer)
	multiplayer = multiplayer or false
	-- Load level
	self.level = Level()
	if not self.level:load(filename) then
		-- TODO: Switch back to the menu and pass an error
	end
	-- Initialize players
	if not multiplayer then
		numberOfPlayers = 1
		self.player1:init(1,dt, self.level)
		self.player1.level_offset = Vector(0, 0)
	else
		numberOfPlayers = 2
		self.player1:init(1,dt, self.level)
		self.player1.level_offset = Vector(0, 0)
		self.player2:init(1,dt, self.level)
		self.player2.level_offset = Vector(0, 0)
	end
	
	-- Background images
	self.stars_far = love.graphics.newImage("graphics/stars1.png")
	self.stars_near = love.graphics.newImage("graphics/stars2.png")
	
	--initilize sound
	TEsound.playLooping("sound/main.ogg", {"music"} , nil, 1)
	--TODO tesound
	
end

function game:leave()
	self.level:unload()
	for i = 1, numberOfPlayers do
		self["player"..i].spaceship:destroy()
	end
end

function game:update(dt)
	dt = math.min(dt, tonumber(setting:getValue("framerate", tostring(1/30))))
	--Let the players check the input devices
	for i = 1, numberOfPlayers do
		self["player"..i]:checkInput(dt)
	end
	for i = 1, numberOfPlayers do
		self["player"..i].spaceship:update(dt, self.level)
		self["player"..i].spaceship:restrictArea(Vector(0, 0), Vector(self.level.level_width, self.level.level_height))
		-- Update the arrow
		self["player"..i].arrow:update()
	end
	local pitchValue = self.player1.spaceship:getSpeed() + 1
	if pitchValue < 0  then 
	pitchValue = pitchValue * -1
	end


	if pitchValue < 0  then 
	local pitchValue = (self.player1.spaceship:getSpeed() + 1)/10
	pitchValue = pitchValue * (-1)
	end
	TEsound.cleanup()
	TEsound.tagPitch("all", pitchValue)
	HC.update(dt)
end

function game:draw()
	for i = 1, numberOfPlayers do
		local player_position = Vector(self["player"..i].spaceship.x, self["player"..i].spaceship.y)
		-- Calculate screen area
		-- TODO
		local scissor_top_left = Vector(0, 0)
		local scissor_size = Vector(love.graphics.getWidth(), love.graphics.getHeight())
		-- Level offset
		local level_offset = self["player"..i].level_offset
		local relative_position = player_position - level_offset
		local spaceship_area_min = scissor_size * 0.25
		local spaceship_area_max = scissor_size * 0.75
		if relative_position.x > spaceship_area_max.x then
			level_offset.x = level_offset.x + relative_position.x - spaceship_area_max.x
		end
		if relative_position.y > spaceship_area_max.y then
			level_offset.y = level_offset.y + relative_position.y - spaceship_area_max.y
		end
		if relative_position.x < spaceship_area_min.x then
			level_offset.x = level_offset.x + relative_position.x - spaceship_area_min.x
		end
		if relative_position.y < spaceship_area_min.y then
			level_offset.y = level_offset.y + relative_position.y - spaceship_area_min.y
		end
		-- TODO: Offset 
		love.graphics.setScissor(scissor_top_left.x, scissor_top_left.y,
			scissor_size.x, scissor_size.y)
		-- Level background
		local bg_near_offset = -Vector(level_offset.x / 2 % 256, level_offset.y / 2 % 256)
		local bg_far_offset = -Vector(level_offset.x / 4 % 256, level_offset.y / 4 % 256)
		bg_far_offset = bg_far_offset + scissor_top_left
		local bg_repeat_horizontal = math.floor((scissor_size.x + 255) / 256) + 1
		local bg_repeat_vertical = math.floor((scissor_size.y + 255) / 256) + 1
		for x=0,bg_repeat_horizontal-1 do
			for y=0,bg_repeat_vertical-1 do
				love.graphics.draw(self.stars_far, bg_far_offset.x + x * 256, bg_far_offset.y + y * 256, 0, 1, 1, 0, 0)
			end
		end
		for x=0,bg_repeat_horizontal-1 do
			for y=0,bg_repeat_vertical-1 do
				love.graphics.draw(self.stars_near, bg_near_offset.x + x * 256, bg_near_offset.y + y * 256, 0, 1, 1, 0, 0)
			end
		end
		-- Level border
		love.graphics.setLine(2, "smooth")
		love.graphics.line(0 - level_offset.x, 0 - level_offset.y,
			0 - level_offset.x, self.level.level_height - level_offset.y)
		love.graphics.line(0 - level_offset.x, self.level.level_height - level_offset.y,
			self.level.level_width - level_offset.x, self.level.level_height - level_offset.y)
		love.graphics.line(0 - level_offset.x, 0 - level_offset.y,
			self.level.level_width - level_offset.x, 0 - level_offset.y)
		love.graphics.line(self.level.level_width - level_offset.x, 0 - level_offset.y,
			self.level.level_width - level_offset.x, self.level.level_height - level_offset.y)
		-- Draw level
		self.level:drawFieldVectors(level_offset, scissor_top_left,
			scissor_size, player_position, 200)
		self.level:draw(level_offset, scissor_top_left,
			scissor_size)
		self["player"..i].arrow:draw()
		--Let the players draw the spaceships
		for j = 1, numberOfPlayers do
			self["player"..j].spaceship:draw(level_offset)
		end
		love.graphics.setScissor()
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

function on_collision(dt, a, b)
	if a == game["player1"].spaceship.hardonPolygon or b == game["player1"].spaceship.hardonPolygon then
		print("abc", a, b)
	end
end

function collision_stop(dt, a, b)
	print("collision stop")
end