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
	self.grid_cell_width = 10
	self.magnets = {}
	self:loadFromFile()

	--Initialize Magnets

	-- We sample the field strength every x pixels
	self.grid_width = self.level_width / self.grid_cell_width
	self.grid_height = self.level_height / self.grid_cell_width
	-- Create empty two-dimensional array
	self.field_raster = {}
	local x=1
	local y=1
	for x=1,self.grid_width do
		local line = {}
		for y=1,self.grid_height do
			-- Initialize the array with zero field width
			line[y] = Vector:new(0, 0)
		end
		self.field_raster[x] = line
	end
	-- Add influence of all magnets to the field strength grid
	for magnet in magnets do
		for x=1,self.grid_width do
			local line = {}
			for y=1,self.grid_height do
				-- Initialize the array with zero field width
				line[y] = Vector:new(0, 0)
			end
			self.field_raster[x] = line
		end
	end

	return false
end

function Level:loadFromFile()
	for line in love.filesystem.lines("levels/" + filename) do
		local words = splitWords(line)
		if words ~= nil then
			if words[1] == "level_width" and #words == 2 then
				self.level_width = tonumber(words[2])
			elseif words[1] == "level_height" and #words == 2 then
				self.level_height = tonumber(words[2])
			elseif words[1] == "grid_cell_width" and #words == 2 then
				self.grid_cell_width = tonumber(words[2])
			elseif words[1] == "magnet" then
				local new_magnet = {}
				new_magnet.pos_x = tonumber(words[2])
				new_magnet.pos_y = tonumber(words[3])
				new_magnet.rot = tonumber(words[4])
				new_magnet.length = tonumber(words[5])
				new_magnet.width = tonumber(words[6])
				new_magnet.fieldStrength = tonumber(words[7])
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
end


function Level:getFieldVector(x, y)
	-- Bilinear interpolation between nearest sampled values
	local floor_x = math.max(math.floor(x), 1)
	local ceil_x = math.min(math.ceil(x), self.grid_width)
	local floor_y = math.max(math.floor(y), 1)
	local ceil_y = math.min(math.ceil(y), self.grid_height)
	local fraction_x = x - floor_x
	local fraction_y = y - floor_y
	-- Clamp values into [1..0]
	fraction_x = math.max(math.min(fraction_x, 1), 0)
	fraction_y = math.max(math.min(fraction_y, 1), 0)
	local v_0 = self.field_raster[floor_x][floor_y]
	local v_1 = self.field_raster[floor_x][ceil_y]
	local v_2 = self.field_raster[ceil_x][floor_y]
	local v_3 = self.field_raster[ceil_x][ceil_y]
	-- Interpolation along y axis
	v_0 = v_0:interpolate(v_1, fraction_y)
	v_2 = v_2:interpolate(v_3, fraction_y)
	-- Interpolation along z axis
	return v_0:interpolate(v_2, fraction_x)
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

