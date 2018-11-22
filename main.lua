-- our main table
game = {}

-- store images
game.images = {}
game.image = function(path)
    local img = game.images[path]

    if img == nil then
        img = love.graphics.newImage(path)
        game.images[path] = img
    end

    return img
end

-- all entities
game.ents = {}
game.addEnt = function(e)
    game.ents[game.ents_counter] = e
    game.ents_counter = game.ents_counter + 1
end

game.ents_counter = 0

-- includes
require 'glob'
require 'timer'
require 'vec'
require 'ent'
require 'particle'
require 'levels'

-- init vars
love.load = function()
    levels:load('wow')
end

-- draw the game
love.draw = function()
    levels:draw()

    for _, e in pairs(game.ents) do
        if e and not e._null then e:draw() end
    end
end

love.update = function(dt)
    levels:update(dt)

    for _, e in pairs(game.ents) do
        if e and not e._null then e:think(dt) end
    end

    timer:tick(dt)
end