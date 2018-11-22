require 'levels/wow/cube'

local _ = {}

local wasdcube
local arrowcube
function _:load()
    wasdcube = cube(vec(10, 10), {0.1, 0.1, 0.1}, 64)
    arrowcube = cube(vec(100, 10), {0.2, 0.2, 0.2}, 100, 'up', 'left', 'down', 'right')
end

function _:draw()
    love.graphics.draw(game.image("images/background.jpg"), 0, 0)
end

function _:exit()
    wasdcube:remove()
    arrowcube:remove()
end

return _