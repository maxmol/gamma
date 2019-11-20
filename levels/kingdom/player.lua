-- controlled player
player = {}
player.extends = ent

player.ANIM_IDLE = 0
player.ANIM_RUN = 1
player.ANIM_SIT = 2

function player:draw()
    local pos = self:getPos()
    self.idle_anim:draw(pos.x, pos.y, self.looking_right and 4 or -4, 4)

    --[[love.graphics.setColor(0, 0, 0, 255)
    love.graphics.rectangle('fill', pos.x - 4, pos.y - 4, 8, 8)
    love.graphics.setColor(255, 255, 255, 255)]]
end

function player:changeAnim(anim_state)
    if anim_state == 0 then
        self.idle_anim:setStartEnd(1, 4)
    elseif anim_state == 1 then
        self.idle_anim:setStartEnd(9, 14)
    elseif anim_state == 2 then
        self.idle_anim:setStartEnd(5, 8)
    end
end

local isDown = love.keyboard.isDown
function player:think(dt)
    local move = vec()

    local pressing_down = isDown(self.down)
    local pressing_right = not pressing_down and isDown(self.right)
    local pressing_left = not pressing_down and isDown(self.left)

    if pressing_right then
        move.x = 1
    end

    if pressing_left then
        move.x = -1
    end

    if move.x > 0 then
        self.looking_right = true
    elseif move.x < 0 then
        self.looking_right = false
    end

    local anim_state = self.ANIM_IDLE

    if pressing_down then
        anim_state = self.ANIM_SIT
    elseif pressing_right or pressing_left then
        anim_state = self.ANIM_RUN
    end

    if anim_state ~= self.anim_state then
        self:changeAnim(anim_state)
        self.anim_state = anim_state
    end

    local pos = self:getPos() + move * 150 * dt
    self:setPos(pos)

    self.idle_anim:think(dt)
end

function player:generate(pos, up, left, down, right)
    if pos then self:setPos(pos) end
    self.left = left or 'a'
    self.down = down or 's'
    self.right = right or 'd'

    self.idle_anim = anim(love.graphics.newImage("assets/player.png"), 50, 37)
    self.looking_right = true
end

game.class(player)