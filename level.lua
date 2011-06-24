HC = require 'hardoncollider'
Class = require 'hump.class'
Vector = require 'hump.vector'

require "utility"

local magnet_img = love.graphics.newImage("graphics/Magnet-Test.png")




Level = Class(function(self)
end)

function Level:load(filename)
	-- Open level file
	self.level_width = 0
	self.level_height = 0
	self.grid_cell_width = 10
	self.magnets = {}
	self:loadFromFile(filename)

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
			-- Initialize the array with zero field strength
			line[y] = Vector.new(0.5, 0.5)
		end
		self.field_raster[x] = line
	end

	return false
end

function Level:loadFromFile(filename)
	for line in love.filesystem.lines("levels/"..filename) do
		local words = splitWords(line)
		if #words ~= 0 then
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
				table.insert(self.magnets, new_magnet)
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

function Level:calcMagnetField()
	-- Add influence of all magnets to the field strength grid
	for magnet in self.magnets do
		--The Edgepositions of the Magnet in Rasterunits
		magnet.edges = self:calcMagnetEdgePos(magnet)
		for point in magnet.edges do
    		for x=1,self.grid_width do
    		  local line = {}
    		  for y=1,self.grid_height do
    		      local fieldStrength = self:calcFieldStrengthAtPoint(magnet.fieldStrength, point, x, y)
    		      line[y] = Vector.new(0.5, 0.5)
    		  end
    		  self.field_raster[x] = line
    		end
    	end
    end
end

function Level:calcMagnetEdgePos(magnet)
    edgeX = {}
	--The first Edge (north)
	local x1 = (magnet.pos_x - math.sin(magnet.rot)*magnet.length) / self.grid_cell_width
	local y1 = (magnet.pos_y - math.cos(magnet.rot)*magnet.length) / self.grid_cell_width
	edgeX[1].point = Vector.new(x1, y1)
	edgeX[1].pole = -1
	--The second Edge (south)
	local x1 = (magnet.pos_x + math.sin(magnet.rot)*magnet.length) / self.grid_cell_width
	local y1 = (magnet.pos_y + math.cos(magnet.rot)*magnet.length) / self.grid_cell_width
	edgeX[2].point = Vector.new(x2, y2)
	edgeX[2].pole = 1
	return edgeX
end

function Level:calcFieldStrengthAtPoint(fieldStrength, point, x, y)
    --distance
    local dist = math.sqrt((point.point.x-x)^2+(point.point.y-y)^2)
    --strength
    return point.pole*fieldStrength/(dist^2)
end

function Level:calcFieldDirection(point, x, y)
    local dir = vector.new(point.point.x-x, point.point.y-y)
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

function Level:draw(level_offset, scissor_top_left, scissor_size)
	love.graphics.setScissor(scissor_top_left.x, scissor_top_left.y,
		scissor_size.x, scissor_size.y)
	-- Draw magnets
	for _,magnet in pairs(self.magnets) do
		love.graphics.draw(magnet_img, magnet.pos_x, magnet.pos_y, rotation,
			magnet.length / 200, magnet.width / 100, 100, 50)
	end
	-- Draw fields around the magnets
	-- TODO
	love.graphics.setScissor()
end

function Level:drawFieldVectors(level_offset, scissor_top_left, scissor_size, position, radius)
	love.graphics.polygon('fill', 	 50, 1,											--top point
					19, 13,  4, 37,  1, 54,  2, 91,  9, 110,  30, 133,  14, 145,  6, 162, 9, 281, 		--left side 
					89, 281,  92, 162,  85, 145,  68, 133,  89, 110,  97, 91,  98, 54,  95, 37,  80, 13) 	--right side
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.setLine(1, "smooth")
	love.graphics.setScissor(scissor_top_left.x, scissor_top_left.y,
		scissor_size.x, scissor_size.y)
	local circle_top_left = vec_ceil(position + Vector.new(-radius, -radius))
	local circle_bottom_right = vec_floor(position + Vector.new(radius, radius))
	-- Clamp drawing into field grid dimensions
	circle_top_left.x = math.min(math.max(circle_top_left.x, 1), #self.field_raster)
	circle_bottom_right.x = math.min(math.max(circle_bottom_right.x, 1), #self.field_raster)
	circle_top_left.y = math.min(math.max(circle_top_left.y, 1), #self.field_raster[1])
	circle_bottom_right.y = math.min(math.max(circle_bottom_right.y, 1), #self.field_raster[1])
	-- Draw all field strength vectors within the circle
	for x=circle_top_left.x,circle_bottom_right.x,self.grid_cell_width do
		for y=circle_top_left.y,circle_bottom_right.y,self.grid_cell_width do
			local current_pos = Vector.new(x, y)
			if (current_pos - position):len2() < radius^2 then
				self:drawFieldVector(level_offset, current_pos)
			end
		end
	end
	love.graphics.setScissor()
end

function Level:drawFieldVector(level_offset, position)
	local arrow_start = level_offset + position
	local grid_position = vec_round(position / self.grid_cell_width)
	-- Main arrow line
	local field_strength = self.field_raster[grid_position.x][grid_position.y]
	field_strength = field_strength * self.grid_cell_width
	local arrow_end = arrow_start + field_strength
	love.graphics.line(arrow_start.x, arrow_start.y, arrow_end.x, arrow_end.y)
	-- Two lines to the sides
	local orthogonal = Vector.new(field_strength.y, -field_strength.x) * 0.3
	local side_end = field_strength * 0.7 + orthogonal + arrow_start
	love.graphics.line(arrow_end.x, arrow_end.y, side_end.x, side_end.y)
	side_end = field_strength * 0.7 - orthogonal + arrow_start
	love.graphics.line(arrow_end.x, arrow_end.y, side_end.x, side_end.y)
end
