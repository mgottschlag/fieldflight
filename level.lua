
Class = require 'hump.class'
Vector = require 'hump.vector'

Level = Class(function(self)
end)

function Level:load(filename)
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

