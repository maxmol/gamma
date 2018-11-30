-- controlled cube
cube = {}
cube.extends = ent

local setColor = love.graphics.setColor
local rectangle = love.graphics.rectangle
function cube:draw()
    setColor(self.color)

    local pos = self:getPos()
    local size = self.size
    
    rectangle('fill', pos.x, pos.y, size, size)

    setColor(255, 255, 255, 255)
end

local isDown = love.keyboard.isDown
function cube:think(dt)
    local move = vec()
    if isDown(self.up) and self:getPos().y + self.size == love.graphics.getHeight() then
        self.vel.y = -100
    end
    if isDown(self.right) then
        move.x = 1
    end
    if isDown(self.left) then
        move.x = -1
    end

    self.vel.y = self.vel.y + move.y + 1

    local pos = self:getPos() + move * 50 * dt + self.vel * dt
    if pos.y + self.size > love.graphics.getHeight() then
        pos.y = love.graphics.getHeight() - self.size
        self.vel.y = math.min(self.vel.y, 0)
    end

    self:setPos(pos)
end

function cube:generate(pos, color, size, up, left, down, right)
    if pos then self:setPos(pos) end
    self.color = color or {0, 0, 0, 0}
    self.size = size or 32
    self.up = up or 'w'
    self.left = left or 'a'
    self.down = down or 's'
    self.right = right or 'd'
    self.vel = vec(0, 0)
end

game.class(cube)