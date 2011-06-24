
Vector = require "hump.vector"

function splitString(splitMe, splitAfterChar)
	local values = {}
	local pos = 1
	while pos <= splitMe.len(splitMe) do
		local endPos = string.find(splitMe, splitAfterChar, pos)
		table.insert(values, string.sub(splitMe, pos, endPos))
		pos = endPos
	end
	return values
end

function splitWords(str)
	local t = {}
	local function helper(word)
		table.insert(t, word)
		return ""
	end
	if not str:gsub("%w+", helper):find"%S" then
		return t
	end
end

function Vector:interpolate(other, delta)
	return self * (1 - delta) + other
end
