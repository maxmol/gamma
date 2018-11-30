local _ = {}

local tiles = {}
for i = 0, 12 do
    tiles[i] = {}
end

local tile = {}

local colors = {
    {0, 0, 0},
    {1, 0, 0},
    {0, 1, 0},
    {0, 0, 1},
    {1, 1, 0},
    {0, 1, 1},
    {1, 0, 1},
    false,
}

local all

local function drawTile(tile, x, y, alpha)
    local color = tile.c or {1, 1, 1}
    love.graphics.setColor(color[1], color[2], color[3], alpha or 1)

    if tile.i then
        local img = game.image(tile.i)
        love.graphics.draw(img, love.graphics.newQuad(0, 0, 64, 64, img:getWidth(), img:getHeight()), x, y)
    else
        love.graphics.rectangle('fill', x, y, 64, 64)
    end
end

function _:load()
    for k, v in ipairs(colors) do
        v = v and v or {1, 1, 1}
        local b = button()
        b:setSize(32, 32) 
        b.color = v
        b:setPos(vec(k * 32, love.graphics.getHeight() - 32))
        b.click = function()
            tile = {c = v}
        end
    end

    for k, v in ipairs(love.filesystem.getDirectoryItems('images/tiles')) do
        v = 'images/tiles/' .. v
        local b = button()
        b:setSize(32, 32) 
        b:setPos(vec((#colors + k + 1) * 32, love.graphics.getHeight() - 32))
        b.draw = function(self)
            local img = game.image(v)
            love.graphics.draw(img, love.graphics.newQuad(0, 0, 32, 32, img:getWidth(), img:getHeight()), self:getPos().x, self:getPos().y)
        end
        b.click = function()
            tile = {i = v}
        end
    end
end

function _:update(dt)
    local x, y = love.mouse.getPosition()
    if y < love.graphics.getHeight() - 32 then
        if love.mouse.isDown(1) then -- left
            local t = {}
            for k, v in pairs(tile) do
                t[k] = v
            end

            tiles[math.floor(x/64)][math.floor(y/64)] = t
        elseif love.mouse.isDown(2) then -- right
            tiles[math.floor(x/64)][math.floor(y/64)] = nil
        end
    end
end

function _:draw()
    for i = 0, 12 do
        for j = 0, 9 do
            if tiles[i][j] then
                drawTile(tiles[i][j], i * 64, j * 64)
            end
        end
    end

    local x, y = love.mouse.getPosition()
    x = x - x % 64
    y = y - y % 64

    drawTile(tile, x, y, 0.5)
end

function _:exit()
    
end

function _:mousepressed(x, y, button, istouch, presses)
    
end

return _