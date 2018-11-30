-- particle entity
button = {}
button.extends = vgui

local setColor = love.graphics.setColor
local rectangle = love.graphics.rectangle
function button:draw()
    setColor(self.color)

    local pos = self:getPos()
    local w, h = self:getWidth(), self:getHeight()
    rectangle('fill', pos.x, pos.y, self:getWidth(), self:getHeight())

    setColor(1, 1, 1, 1)

    rectangle('line', pos.x, pos.y, self:getWidth(), self:getHeight())
end

function button:think(delta)
    
end

function button:generate()
    self.color = {1, 1, 1, 1}
end

game.class(button)