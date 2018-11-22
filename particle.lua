-- particle entity
particle = {}

function particle:draw()
    love.graphics.setColor(self.color)

    local pos = self:getPos()
    local w, h = self.image:getWidth(), self.image:getHeight()
    love.graphics.draw(self.image, pos.x - w*self.size/2, pos.y - h*self.size/2, 0, self.size, self.size)

    love.graphics.setColor(255, 255, 255, 255)
end

function particle:think()
    self:setPos(self:getPos() + self.vel);
    self.vel = self.vel * self.friction;

    local delta = love.timer.getDelta()

    self.color[4] = math.clamp(self.color[4] + (self.endAlpha - self.startAlpha) * delta / self.duration, 0, 255)
    self.size = math.clamp(self.size + (self.endSize - self.startSize) * delta / self.duration, 0)

    self.life = self.life - delta
    if self.life < 0 then
        self:remove()
    end
end

setmetatable(particle, {
    __call = function(_, pos, image, color, startSize, endSize, startAlpha, endAlpha, duration, vel, friction) 
        local e = ent()
        if pos then e:setPos(pos) end
        e.image = image or love.graphics.newImage("images/particle.png")
        e.color = color or {255, 255, 255, 255}
        e.startSize = startSize or 1
        e.endSize = endSize or 0.5
        e.size = e.startSize
        e.startAlpha = startAlpha or 255
        e.endAlpha = endAlpha or 0
        e.duration = duration or 2
        e.life = e.duration
        e.vel = vel or vec()
        e.friction = friction or 1

        setmetatable(e, {__index = particle})

        love.ents[love.ents_counter] = e
        love.ents_counter = love.ents_counter + 1
        
        return e
    end,

    __index = ent
})