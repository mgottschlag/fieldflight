require "utility"
Class = require 'hump.class'


local setting = {
	key="",
	value=""
}

Settings = Class(function(self)
	self.list = {}
	self.path = ""
end)

function Settings.set(key, value)
	local set = {}
	set.key = key
	set.value = value
	return set
end

function Settings:loadSettings( pathIn )
	self.path = pathIn
	if ( love.filesystem.exists(self.path) ) then
		local i = 0
		local line = ""
		for line in love.filesystem.lines(self.path) do
			i = i + 1
			local pair = splitString(line, ",")
			self:insertNewPair(pair[1], pair[2])	
		end
	else
		love.filesystem.newFile(self.path)
	end
end 

function Settings:insertNewPair(key, value)
	table.insert(self.list, Settings.set(key, value))
end

function Settings:getValue( key, default )
	for _,l in pairs(self.list) do
		if l.key == key then
			return l.value
		end
	end
	self:insertNewPair(key, default)
	return default
end

function Settings:setValue(key, value)
	for _,l in pairs(self.list) do
		if l.key == key then
			l.value = value
		end
	end
	self:insertNewPair(key, value)
end


function Settings:saveSettings()
	local data = ""
	for _,l in pairs(self.list) do
		data = data .. l.key .. "," .. l.value .. "\n"
	end
	return love.filesystem.write(self.path, data, 100000)
end

