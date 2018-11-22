local _ = {}

function _:load()
    love.images['background'] = love.graphics.newImage("images/background.jpg")
    love.images['particle'] = love.graphics.newImage("images/particle.png")
    timer.create('bgparticles', 0.1, false, function()
        local p = particle(vec(150, 110), love.images['particle'])
        p.vel = vec(math.random(-100, 100)/100, math.random(-100, 100)/100)
    end)
end

function _:draw()
    love.graphics.draw(love.images['background'], 0, 0)
end

return _