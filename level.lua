HC = require 'hardoncollider'
Class = require 'hump.class'
Vector = require 'hump.vector'

require "utility"

Level = Class(function(self)
end)

function Level:load(filename)
	-- Open level file
	self.level_width = 0
	self.level_height = 0
	self.magnets = {}
	for line in love.filesystem.lines("levels/" + filename) do
		local words = splitWords(line)
		if words ~= nil then
			if words[1] == "level_width" and #words == 2 then
				self.level_width = tonumber(words[2])
			elseif words[1] == "level_height" and #words == 2 then
				self.level_height = tonumber(words[2])
			elseif words[1] == "magnet" then
				local new_magnet = {}
				new_magnet.pos_x = tonumber(words[2])
				new_magnet.pos_y = tonumber(words[3])
				new_magnet.rot = tonumber(words[4])
				new_magnet.length = tonumber(words[5])
				new_magnet.width = tonumber(words[6])
				--new_magnet. = tonumber(words[6])
				table.insert(magnets, new_magnet)
			elseif words[1] == "start" and #words == 3 then
				self.start_x = tonumber(words[2])
				self.start_y = tonumber(words[3])
			elseif words[1] == "end" and #words == 3 then
				self.end_x = tonumber(words[2])
				self.end_y = tonumber(words[3])
			end
		end
	end

	--Initialize Magnets

	-- We sample the field strength every x pixels
	self.grid_cell_width = 10
	--self.grid_width = self.level_width / self.
	-- Initialize table with field strengths
	self.field_raster = {}
	
	-- TODO

	return false
end

function Level:getFieldVector(x, y)
	-- TODO
	return Vector.new(0, 0)
end

function Level:draw(offset, scissor_area)
	-- Set scissor area
	-- TODO
	-- Draw magnets
	-- TODO
end

function Level:drawFieldVectors(x, y, radius)
	-- TODO
end

