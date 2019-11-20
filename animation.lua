-- 2d adumation
local frametime = 0.2

anim = {}
anim.__index = anim

function anim:generate(img, w, h, start_frame, end_frame)
    self.img = img
    self.quads = {}
    self.w = w
    self.h = h
 
    for y = 0, img:getHeight() - h, h do
        for x = 0, img:getWidth() - w, w do
            table.insert(self.quads, love.graphics.newQuad(x, y, w, h, img:getDimensions()))
        end
    end

    self.start_frame = start_frame or 1
    self.end_frame = end_frame or #self.quads

    self.time = 0
    self.frame = self.start_frame
end

function anim:draw(x, y, sx, sy)
    love.graphics.draw(self.img, self.quads[self.frame], x - self.w * sx * 0.5, y - self.h * sy, 0, sx, sy)
end

function anim:think(dt)
    self.time = (self.time + dt) % ((self.end_frame - self.start_frame + 1) * frametime)
    self.frame = math.floor(self.time / frametime) + self.start_frame
end

function anim:setStartEnd(start_frame, end_frame)
    self.start_frame = start_frame or 1
    self.end_frame = end_frame or #self.quads

    self.time = 0
end

game.class(anim)