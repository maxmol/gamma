require 'levels/kingdom/player'

local _ = {}

local ply
function _:load()
    ply = player(vec(10, 500))
end

function _:draw()
    love.graphics.draw(game.image("images/background.jpg"), 0, 0)
end

function _:exit()
    ply:remove()
end

return _