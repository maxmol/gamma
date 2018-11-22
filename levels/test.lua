local _ = {}

function _:load()
    timer.create('bgparticles', 0.1, false, function()
        local p = particle(vec(150, 110))
        p.vel = vec(math.random(-100, 100)/100, math.random(-100, 100)/100)
    end)
end

function _:draw()
    love.graphics.draw(game.image('images/background.jpg'), 0, 0)
end

return _