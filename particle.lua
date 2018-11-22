-- particle entity
particle = {}
particle.extends = ent

local setColor = love.graphics.setColor
local draw = love.graphics.draw
function particle:draw()
    setColor(self.color)

    local pos = self:getPos()
    local w, h = self.image:getWidth(), self.image:getHeight()
    draw(self.image, pos.x - w*self.size/2, pos.y - h*self.size/2, 0, self.size, self.size)

    setColor(255, 255, 255, 255)
end

function particle:think(delta)
    self:setPos(self:getPos() + self.vel);
    self.vel = self.vel * self.friction;

    self.color[4] = math.clamp(self.color[4] + (self.endAlpha - self.startAlpha) * delta / self.duration, 0, 255)
    self.size = math.clamp(self.size + (self.endSize - self.startSize) * delta / self.duration, 0)

    self.life = self.life - delta
    if self.life < 0 then
        self:remove()
    end
end

function particle:generate(pos, image, color, startSize, endSize, startAlpha, endAlpha, duration, vel, friction)
    if pos then self:setPos(pos) end
    self.image = image or game.image("images/particle.png")
    self.color = color or {255, 255, 255, 255}
    self.startSize = startSize or 1
    self.endSize = endSize or 0.5
    self.size = self.startSize
    self.startAlpha = startAlpha or 255
    self.endAlpha = endAlpha or 0
    self.duration = duration or 2
    self.life = self.duration
    self.vel = vel or vec()
    self.friction = friction or 1
end

game.class(particle)