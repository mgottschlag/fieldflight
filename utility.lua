
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

function Vector:interpolate(other, delta)
	return self * (1 - delta) + other
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
