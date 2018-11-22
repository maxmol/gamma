-- includes
require 'glob'
require 'timer'
require 'vec'
require 'ent'
require 'particle'
require 'levels'

-- store images
love.images = {}

-- all entities
love.ents = {}
love.ents_counter = 0

-- init vars
love.load = function()
    levels:load('test')
end

-- draw the game
love.draw = function()
    levels:draw()

    for _, e in pairs(love.ents) do
        if e and not e._null then e:draw() end
    end
end

love.update = function()
    levels:update()

    for _, e in pairs(love.ents) do
        if e and not e._null then e:think() end
    end

    timer:tick()
end