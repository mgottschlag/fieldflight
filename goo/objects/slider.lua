-------------------------------------------------------------
------ SLIDER.
-------------------------------------------------------------
goo.slider = class('goo slider', goo.object)
function goo.slider:initialize( parent )
	super.initialize(self,parent)
	self.current_value  = 0
	self.max_value      = 100
	self.max_width      = 100
	self.dragging       = false
	self:setRange()
end
function goo.slider:draw( x, y )
	local mx,my = love.mouse.getX(), love.mouse.getY()
	local x,y = self:getAbsolutePos()
	if self.dragging and mx >= x and mx <= x+self.w and my >= y and my <= y+self.h then
		local percentage = (mx - x) / self.w * 100
		self:setPercentage(percentage)
	end
	love.graphics.setLine( 1, 'rough' )
	self:setColor( self.borderColor )
	love.graphics.rectangle( 'line', x, y, self.w, self.h )
	love.graphics.setColor( unpack(self.style.backgroundColor) )
	local width = (self.w - 2) * self.current_value / self.max_value
	love.graphics.rectangle( self.style.fillMode, x + 1, y + 1, width, self.h - 2 )
end
function goo.slider:setValue( value )
	self.current_value = value
	local w = self.current_value/self.range
end
function goo.slider:setPercentage( percentage )
	local percentage = percentage or 0
	self.w = self.max_width * (percentage/100)
end
function goo.slider:setRange( min, max )
	local min = min or 0
	local max = max or 100
	self.range = (max-min)
	return self.range
end
function goo.slider:setSize( w, h )
	super.setSize( self, w, h )
	self.max_width = w
	self.scale = self.range / w
end
function goo.slider:updateSize( w, h )
	local w = w or self.w or 0
	local h = h or self.h or 20
	self.w = w
	self.h = h
end
function goo.slider:getValue()
	return self.current_value
end
function goo.slider:getPercentage()
	return (self.w/self.max_width)*100
end

function goo.slider:enterHover()
	self.backgroundColor = self.style.backgroundColorHover
	self.borderColor = self.style.borderColorHover
	self.textColor = self.style.textColorHover
end
function goo.slider:exitHover()
	self.backgroundColor = self.style.backgroundColor
	self.borderColor = self.style.borderColor
	self.textColor = self.style.textColor
end
function goo.slider:mousepressed(x,y,button)
	self.dragging = true
	local mx,my = love.mouse.getX(), love.mouse.getY()
	local x,y = self:getAbsolutePos()
	if self.dragging and mx >= x and mx <= x+self.w and my >= y and my <= y+self.h then
		local percentage = (mx - x) / self.w * 100
		self:setPercentage(percentage)
	end
	if self.onClick then self:onClick(button) end
	self:updateBounds( 'children', self.updateBounds )
end
function goo.slider:mousereleased(x,y,button)
	self.dragging = false
end

return goo.slider


