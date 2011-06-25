
Vector = require "hump.vector"

function splitString(splitMe, splitAfterChar)
	local values = {}
	local pos = 1
	while pos ~= nil do
		local endPos = string.find(splitMe, splitAfterChar, pos)
		if endPos ~= nil then
			table.insert(values, string.sub(splitMe, pos, endPos - 1))
			pos = endPos + 1
		else
			table.insert(values, string.sub(splitMe, pos))
			pos = endPos
		end
	end
	return values
end

function splitWords(str)
	return splitString(str, " ")
end

function vec_interpolate(v1, v2, delta)
	return v1 * (1 - delta) + v2 * delta
end

function vec_floor(v)
	return Vector.new(math.floor(v.x), math.floor(v.y))
end
function vec_ceil(v)
	return Vector.new(math.ceil(v.x), math.ceil(v.y))
end
function vec_round(v)
	return Vector.new(math.floor(v.x + 0.5), math.floor(v.y + 0.5))
end

function drawLineArrow(from, to)
	love.graphics.line(from.x, from.y, to.x, to.y)
	-- Two lines to the sides
	local dir = to - from
	local orthogonal = Vector.new(dir.y, -dir.x) * 0.3
	local side_end = from + 0.7 * dir + orthogonal
	love.graphics.line(to.x, to.y, side_end.x, side_end.y)
	side_end = from + 0.7 * dir - orthogonal
	love.graphics.line(to.x, to.y, side_end.x, side_end.y)
end
